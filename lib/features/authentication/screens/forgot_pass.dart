import 'package:flutter/material.dart';
import 'package:lyrica_ver2/features/authentication/screens/main_login_screen.dart';


class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // back
            Container(
              margin: const EdgeInsets.only(top: 50, left: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            // Logo
            Center(
              child: Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.only(top: 50, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                    image: AssetImage('assets/logos/main_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Text
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Text(
                'No worries!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            // Input Email
            // Form(
            //   child: Column(
            //     children: [
            //       Container(
            //           margin: const EdgeInsets.only(top: 30, left: 24),
            //           child: TextForm(hint: 'Enter your email',controller: TextEditingController(),)),
            //     ],
            //   ),
            // ),
            // Button
            Container(
              width: 360,
              height: 56,
              margin: EdgeInsets.only(top: 30, left: 24),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Send Code',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: Colors.white),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
