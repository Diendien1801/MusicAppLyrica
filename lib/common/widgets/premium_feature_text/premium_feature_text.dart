import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PremiumFeatureText extends StatelessWidget {
  final String text;

  const PremiumFeatureText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // Icon
          Container(
            child: Image.asset(
              'assets/icons/tick.png',
              color: Color.fromRGBO(218, 0, 255, 1),
              height: 20,
              width: 20,
            ),
          ),
          // text
          Container(
            margin: EdgeInsets.only(left: 10, top: 6),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.apply(
                    color: Color.fromRGBO(204, 190, 206, 1),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
