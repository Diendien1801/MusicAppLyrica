import 'package:flutter/material.dart';
import 'package:lyrica_ver2/common/widgets/button/button.dart';
import 'package:lyrica_ver2/common/widgets/button/login_button_social.dart';
import 'package:lyrica_ver2/features/authentication/screens/main_login_screen.dart';
import 'package:lyrica_ver2/features/authentication/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/loginBackground.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.darken)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button
              Center(
                child: LoginButtonSocial(
                  text: 'Continue with Google',
                  logo: 'assets/icons/google.png',
                ),
              ),
              Center(
                child: LoginButtonSocial(
                  text: 'Continue with Facebook',
                  logo: 'assets/icons/facebook.png',
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'OR',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainLoginScreen();
                  }));
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Button(
                      text: 'Login',
                      color: const Color(0xFF6A35DB),
                      textColor: Colors.white,
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 56,
                  width: 360,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Register',
                      style: Theme.of(context).textTheme.titleSmall!.apply(
                            color: const Color.fromRGBO(106, 53, 219, 1),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
