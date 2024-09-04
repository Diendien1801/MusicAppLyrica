import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:lyrica_ver2/data/repositories/authentication.dart';
import 'package:lyrica_ver2/features/authentication/screens/pass_change_success_screen.dart';
import 'package:lyrica_ver2/features/authentication/screens/verification_sceen.dart';
import 'package:lyrica_ver2/utils/effects/loading/fullscreen_loader.dart';

class ResetPassController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  static ResetPassController get instance => Get.find();

  Future<void> resetPassword() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Logging you in...', 'assets/animations/lyrica.json');
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await Future.delayed(const Duration(milliseconds: 1300));
      await AuthenticationRepository.instance
          .resetPassword(emailController.text.trim());
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
