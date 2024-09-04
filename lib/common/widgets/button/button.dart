// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String text;
  Color color;
  Color textColor;
  Button({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 360,
      margin: const EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        color: color, // Color(0xFF6A35DB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.titleSmall!.apply(color: textColor),
        ),
      ),
    );
  }
}
