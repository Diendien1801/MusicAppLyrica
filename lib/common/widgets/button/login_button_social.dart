// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LoginButtonSocial extends StatelessWidget {
  String text;
  String logo;
  Color? color;
  LoginButtonSocial({
    Key? key,
    required this.text,
    required this.logo,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 360,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 14,
            child: Container(
              child: Image.asset(
                logo,
                color: color,
              ),
              height: 25,
              width: 25,
            ),
          ),
          Positioned(
            top: 14,
            left: 60,
            child: Container(
              width: 260,
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
