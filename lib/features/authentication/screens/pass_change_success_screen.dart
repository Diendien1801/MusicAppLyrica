import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lyrica_ver2/features/authentication/screens/login/login_screen.dart';
import 'package:lyrica_ver2/utils/constants/colors.dart';


class PasswordChangeSuccessfullyScreen extends StatelessWidget {
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
                child: Icon(Icons.check, color: Colors.white, size: 70),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 0),
              child: Text(
                'Check your mail!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Container(
              height: 60,
              width: 300,
              margin: const EdgeInsets.only(left: 0),
              child: Text(
                'Back to login screen to login with your new password',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Color.fromRGBO(131, 145, 161, 1)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 56,
              width: 360,
              margin: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(() => LoginScreen());
                },
                child: Text(
                  'Back to Login',
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
