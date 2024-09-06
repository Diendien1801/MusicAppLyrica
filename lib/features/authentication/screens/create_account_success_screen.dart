import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lyrica_ver2/features/authentication/screens/choose_avatar_screen.dart';
import 'package:lyrica_ver2/utils/constants/colors.dart';

class CreateAccountSuccessScreen extends StatelessWidget {
  const CreateAccountSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          // LOGO
          Center(
            child: Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(top: 200, bottom: 50),
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 70),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0),
            child: Text(
              'Congratulation!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Container(
            height: 60,
            width: 200,
            margin: const EdgeInsets.only(left: 0),
            child: Text(
              'You have created a Lyrica account!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: const Color.fromRGBO(131, 145, 161, 1)),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 56,
            width: 360,
            margin: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() => ChooseAvatarScreen(fromEdit: false));
              },
              child: Text(
                'Next',
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
