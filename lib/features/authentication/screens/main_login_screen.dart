// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lyrica_ver2/features/authentication/controllers/login/login_controller.dart';

import 'package:lyrica_ver2/features/authentication/screens/reset_pass_screen.dart';
import 'package:lyrica_ver2/utils/validators/validator_text_form.dart';

class MainLoginScreen extends StatelessWidget {
  const MainLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(13, 3, 25, 1),
          ),
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
                  'Welcome back!',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24),
                child: Text(
                  'Glad to see you, Again!',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),

              // Input Email and Password
              Form(
                key: loginController.loginFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 50, left: 24),
                            height: 56,
                            width: 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.transparent),
                              color: const Color.fromRGBO(41, 27, 60, 1),
                            ),
                          ),
                          Positioned(
                            top: 52,
                            left: 24,
                            child: SizedBox(
                              height: 120,
                              width: 360,
                              child: TextFormField(
                                controller: loginController.email,
                                validator: (value) =>
                                    ValidatorTextForm.validateEmail(value!),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  hintText: 'Enter your email',
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
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    // Customize the border color when focused and there's an error
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        height: 80,
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
                              top: 10,
                              left: 24,
                              child: SizedBox(
                                height: 120,
                                width: 360,
                                child: TextFormField(
                                  obscureText:
                                      loginController.hidePassword.value,
                                  controller: loginController.password,
                                  validator: (value) =>
                                      ValidatorTextForm.validatePassword(
                                          value!),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 20, top: 5),
                                    hintText: 'Password',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(
                                          color:
                                              const Color.fromRGBO(133, 128, 167, 1),
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
                                  loginController.togglePassword();
                                },
                                child: loginController.hidePassword.value
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
              // Forgot Password
              InkWell(
                onTap: () {
                  Get.to(() => ResetPasswordScreen());
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 0, left: 246),
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: const Color.fromRGBO(195, 71, 216, 1),
                        ),
                  ),
                ),
              ),
              // Login Button
              Container(
                width: 360,
                height: 56,
                margin: const EdgeInsets.only(top: 15, left: 24),
                child: ElevatedButton(
                    onPressed: () {
                      loginController.login();
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: const Text('Login')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  String hint;
  TextEditingController controller;
  // ignore: non_constant_identifier_names
  Function? ValidatorTextForm;
  TextForm({
    super.key,
    required this.hint,
    required this.controller,
    // ignore: non_constant_identifier_names
    required this.ValidatorTextForm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent),
        color: const Color.fromRGBO(41, 27, 60, 1),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) => ValidatorTextForm!(value),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, top: 5),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.apply(
                color: const Color.fromRGBO(133, 128, 167, 1),
              ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ), // Add closing parenthesis here
      ),
    );
  }
}
