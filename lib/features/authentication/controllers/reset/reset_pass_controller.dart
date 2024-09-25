import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/authentication/screens/pass_change_success_screen.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart';

class ResetPassController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  static ResetPassController get instance => Get.find();

  Future<void> resetPassword() async {
    try {

      // show loading dialog
      FullScreenLoader.openLoadingDialog(
          'Logging you in...', 'assets/animations/lyrica.json');
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // stop time 1s
      await Future.delayed(const Duration(milliseconds: 1300));

      // reset password
      await AuthenticationRepository.instance
          .resetPassword(emailController.text.trim());

      // stop loading and navigate to password change successfully screen
      FullScreenLoader.stopLoading();
      Get.to(() => PasswordChangeSuccessfullyScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Get.snackbar('Error', 'Something went wrong');
    }
    FullScreenLoader.openLoadingDialog(
        'Logging you in...', 'assets/animations/lyrica.json');
    if (formKey.currentState!.validate()) {
      FullScreenLoader.stopLoading();
      return;
    }
  }
}
