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

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.snackbar('Thank you', 'Your email has been verified');
        Get.off(() => CreateAccountSuccessScreen());
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
