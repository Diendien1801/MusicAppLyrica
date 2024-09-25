import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/user_model.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; // show or hide password
  final email = TextEditingController(); // email controller
  final password = TextEditingController(); // password controller
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// -- TOGGLE PASSWORD
  void togglePassword() {
    hidePassword.value = !hidePassword.value;
  }

  // fetch current user
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userDoc.exists) {
        return UserModel.fromSnapshot(userDoc);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      return null;
    }
  }

  /// -- LOGIN
  Future<void> login() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Logging you in...', 'assets/animations/lyrica.json');
      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // stop time 1s
      await Future.delayed(const Duration(milliseconds: 1300));
      //login user in the firebase authentication
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      final uid = userCredential.user?.uid;

      // fetch playlist
      //final controller = Get.put(PlaylistController());
      // await controller.fetchPlaylists();
      // await controller.fetchMyPlaylists(userCredential.user!.uid);

      // fetch user data
      if (uid != null) {
        final userData = await fetchUserData(uid);
        // check if user is banned
        if (userData?.isBanned == true) {
          FullScreenLoader.stopLoading();
          Get.snackbar('Try again', 'Your account has been banned');
          return;
        } else {
          // redirect to home screen
          
          AuthenticationRepository.instance
              .screenRedirect(AuthenticationRepository.instance.AuthUser);

          Get.snackbar('Have a good day', 'Hôm nay MCK ra bài mới đấy');
        }
      }

      // Animation transition
    } on FirebaseAuthException catch (e) {
      FullScreenLoader.stopLoading();
      if (e.code == 'invalid-credential') {
        Get.snackbar(
            'Try again', 'Your account does not exist. Please sign up first.');
      }
      if (e.code == 'user-not-found') {
        Get.snackbar('Try again', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Try again', 'Wrong pass word provided for that user.');
      }
    } catch (e) {
      Get.snackbar('Try Again', "Something went wrong");
    }
  }
}
