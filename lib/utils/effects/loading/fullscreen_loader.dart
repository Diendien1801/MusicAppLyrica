import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lyrica_ver2/utils/constants/colors.dart';
import 'package:lyrica_ver2/utils/effects/loading/loader.dart';
import 'package:lyrica_ver2/utils/helpers/helpers.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Use this for overlay dialogs
      barrierDismissible:
          false, // The dialog can't be dissmised by clicking outside
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? Color.fromRGBO(75, 34, 116, 1)
              : TColors.light,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              AnimationLoaderWidget(
                  text: text, animation: animation, isIntro: false),
            ],
          ),
        ),
      ),
    );
  }

  static void openIntro(String animation) {
    showDialog(
      context: Get.overlayContext!, // Use this for overlay dialogs
      barrierDismissible:
          false, // The dialog can't be dissmised by clicking outside
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? Colors.black
              : TColors.light,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: AnimationLoaderWidget(
                    text: '', animation: animation, isIntro: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void openIntro2(String animation) {
    showDialog(
      context: Get.overlayContext!, // Use this for overlay dialogs
      barrierDismissible:
          false, // The dialog can't be dissmised by clicking outside
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? Colors.black
              : TColors.light,
          width: double.infinity,
          height: double.infinity,
          child: Container(
            height: 1000,
            child: AnimationLoaderWidget(
                text: '', animation: animation, isIntro: true),
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
