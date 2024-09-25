import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/authentication/screens/create_account_success_screen.dart';
import 'package:lyrica_ver2/features/music/screens/navigation_menu.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    setTimerForAutoRedirect();
    sendEmailVerification();

    super.onInit();
  }
  // send email verification
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  // set timer for auto redirect
  setTimerForAutoRedirect() {
    
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      // reload user's data -> get latest data
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      // check if email is verified
      // if email is null -> false
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.snackbar('Thank you', 'Your email has been verified');
        Get.off(() => CreateAccountSuccessScreen());
      }
      else {
        // if email is not verified
        Get.snackbar('Notice', 'Your email has not been verified yet');
      }
    });
  }

  checkEmailVerification() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => NavigationMenu(),
      );
    }
  }
}
