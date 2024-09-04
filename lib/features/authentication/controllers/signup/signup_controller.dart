import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/models/playlist_model.dart';
import 'package:lyrica_ver2/data/models/user_model.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/data/repositories/user/user_repository.dart';
import 'package:lyrica_ver2/features/authentication/screens/verification_sceen.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  /// -- TOGGLE PASSWORD
  void togglePassword() {
    hidePassword.value = !hidePassword.value;
  }

  /// -- TOGGLE CONFIRM PASSWORD
  void toggleConfirmPassword() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  /// --  SIGNUP

  Future<void> signup() async {
    try {
      // Form validation
      if (!signUpFormKey.currentState!.validate()) {
        return;
      }
      //resigter user int the firebase authentication & save user data in firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      print('1');
      // Save Authenticated User
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        username: username.text.trim(),
        isPremium: false,
        isBanned: false,
        playlist: PlaylistModel(id: '', name: 'Favorite', songs: [], stt: ''),
      );
      print('2');
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      final controller = Get.put(PlaylistController());
      await controller.fetchPlaylists();

      await PlaylistController.to.fetchMyPlaylists(
        userCredential.user!.uid,
      );
      print('3');
      Get.to(() => VerificationScreen());
    } on FirebaseAuthException catch (e) {
      FullScreenLoader.stopLoading();
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Try again', 'The account already exists for that email.');
      }
    } catch (e) {
      Get.snackbar('Try Again', "Something went wrong");
    }
  }
}
