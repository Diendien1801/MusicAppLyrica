import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lyrica_ver2/data/repositories/music/music_repository.dart';
import 'package:lyrica_ver2/features/authentication/screens/login/login_screen.dart';
import 'package:lyrica_ver2/features/authentication/screens/verification_sceen.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/music/screens/navigation_menu.dart';
import 'package:lyrica_ver2/features/music/screens/track_view_screen.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart'; // Import the correct package

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get authenticated user data
  // ignore: non_constant_identifier_names
  User? get AuthUser => _auth.currentUser;

  /// Call from main.dart on app launch
  @override
  void onReady() async {
    super.onReady();

    
    await TrackViewController.to.fetchSongs();
    screenRedirect(_auth.currentUser);
  }

  screenRedirect(User? user) async {
    final playlistController = Get.put(PlaylistController());
    await playlistController.fetchPlaylists();
    // Local storage
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => NavigationMenu());
      } else {
        Get.to(() => VerificationScreen());
      }
    } else {
      FullScreenLoader.openIntro('assets/animations/introvip1.json');
      //stop 1 s
      await Future.delayed(const Duration(milliseconds: 4600));
      FullScreenLoader.stopLoading();

      Get.offAll(() => const LoginScreen());
    }
  }

  /// -- REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  /// MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  /// -- LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// -- LOGOUT
  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// -- RESET PASSWORD
  /// Send a password reset email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }
}
