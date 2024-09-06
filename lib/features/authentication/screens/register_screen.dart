import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/features/authentication/controllers/signup/signup_controller.dart';
import 'package:lyrica_ver2/utils/validators/validator_text_form.dart';

class RegisterScreen extends StatelessWidget {
  final controller = Get.put(SignupController());

   RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back
            Container(
              margin: const EdgeInsets.only(top: 50, left: 24),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // LOGO
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
            // WELCOME
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Text(
                'Register to get',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Text(
                'started!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),

            // Input Email and Password
            Form(
              key: controller.signUpFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 114,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30, left: 24),
                          height: 56,
                          width: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.transparent),
                            color: const Color.fromRGBO(41, 27, 60, 1),
                          ),
                        ),
                        Positioned(
                          top: 34,
                          left: 24,
                          child: SizedBox(
                            height: 120,
                            width: 360,
                            child: TextFormField(
                              controller: controller.username,
                              validator: (value) =>
                                  ValidatorTextForm.validateUsername(value!),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                hintText: 'Username',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: const Color.fromRGBO(133, 128, 167, 1),
                                    ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ), // Add closing parenthesis here
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 74,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 24),
                          height: 56,
                          width: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.transparent),
                            color: const Color.fromRGBO(41, 27, 60, 1),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          left: 24,
                          child: SizedBox(
                            height: 120,
                            width: 360,
                            child: TextFormField(
                              controller: controller.email,
                              validator: (value) =>
                                  ValidatorTextForm.validateEmail(value!),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                hintText: 'Email',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: const Color.fromRGBO(133, 128, 167, 1),
                                    ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ), // Add closing parenthesis here
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: 84,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 24),
                            height: 56,
                            width: 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: const Color.fromRGBO(41, 27, 60, 1),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            left: 24,
                            child: SizedBox(
                              height: 120,
                              width: 360,
                              child: TextFormField(
                                obscureText: controller.hidePassword.value,
                                controller: controller.password,
                                validator: (value) =>
                                    ValidatorTextForm.validatePassword(value!),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  hintText: 'Password',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: const Color.fromRGBO(133, 128, 167, 1),
                                      ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when there's an error
                                  ),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when focused and there's an error
                                  ),
                                ), // Add closing parenthesis here
                              ),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                controller.togglePassword();
                              },
                              child: controller.hidePassword.value
                                  ? Image.asset(
                                      'assets/icons/hide_pass.png',
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    )
                                  : Image.asset(
                                      'assets/icons/show_pass.png',
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      height: 82,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 24),
                            height: 56,
                            width: 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: const Color.fromRGBO(41, 27, 60, 1),
                            ),
                          ),
                          Positioned(
                            top: 12,
                            left: 24,
                            child: SizedBox(
                              height: 120,
                              width: 360,
                              child: TextFormField(
                                obscureText:
                                    controller.hideConfirmPassword.value,
                                controller: controller.confirmPassword,
                                validator: (value) =>
                                    ValidatorTextForm.validatePassword(value!),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  hintText: 'Confirm Password',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                        color: const Color.fromRGBO(133, 128, 167, 1),
                                      ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when there's an error
                                  ),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .transparent), // Customize the border color when focused and there's an error
                                  ),
                                ), // Add closing parenthesis here
                              ),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                controller.toggleConfirmPassword();
                              },
                              child: controller.hideConfirmPassword.value
                                  ? Image.asset(
                                      'assets/icons/hide_pass.png',
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    )
                                  : Image.asset(
                                      'assets/icons/show_pass.png',
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Register Button
            Container(
              width: 360,
              height: 56,
              margin: const EdgeInsets.only(top: 40, left: 24),
              child: ElevatedButton(
                  onPressed: () {
                    controller.signup();
                  },
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: const Text('Register')),
            ),
          ],
        ),
      ),
    );
  }
}
