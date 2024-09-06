import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lyrica_ver2/features/authentication/controllers/reset/reset_pass_controller.dart';
import 'package:lyrica_ver2/utils/validators/validator_text_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  final controller = Get.put(ResetPassController());

   ResetPasswordScreen({super.key});
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
            // Text
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Text(
                'Create',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Text(
                'new password!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),

            Form(
              key: controller.formKey,
              child: SizedBox(
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
                          controller: controller.emailController,
                          validator: (value) =>
                              ValidatorTextForm.validateEmail(value!),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 20, top: 5),
                            hintText: 'Enter your email',
                            hintStyle:
                                Theme.of(context).textTheme.bodyMedium!.apply(
                                      color: const Color.fromRGBO(133, 128, 167, 1),
                                    ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .transparent), // Customize the border color when there's an error
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              // Customize the border color when focused and there's an error
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 56,
              width: 360,
              margin: const EdgeInsets.only(top: 20, left: 24),
              child: ElevatedButton(
                onPressed: () {
                  controller.resetPassword();
                },
                child: const Text('Reset Password'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
