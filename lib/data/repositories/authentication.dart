import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lyrica_ver2/features/authentication/screens/login/login_screen.dart';
import 'package:lyrica_ver2/features/authentication/screens/verification_sceen.dart';
import 'package:lyrica_ver2/features/music/controllers/playlist_controller.dart';
import 'package:lyrica_ver2/features/music/controllers/track_view_controller.dart';
import 'package:lyrica_ver2/features/music/screens/navigation_menu.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart'; // Import the correct package

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  
  final _auth = FirebaseAuth.instance;

  // Get authenticated user data
  // ignore: non_constant_identifier_names
  User? get AuthUser => _auth.currentUser;

  
  @override
  void onReady() async {
    super.onReady();

    screenRedirect(_auth.currentUser);
  }

  screenRedirect(User? user) async {
    final playlistController = Get.put(PlaylistController());
    
    // Check if user is logged in
    if (user != null) {
      if (user.emailVerified) {
        await playlistController.fetchPlaylists();

        await TrackViewController.to.fetchSongs();
        await playlistController.fetchMyPlaylists(user!.uid);
        FullScreenLoader.stopLoading();
        Get.offAll(() => NavigationMenu());
      } else {
        Get.to(() => VerificationScreen());
      }
      // If user is not logged in
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
