import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PremiumPack extends StatelessWidget {
  bool isBestChoice;
  String title;
  String price;

  PremiumPack(
      {required this.isBestChoice, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    if (isBestChoice) {
      return Container(
        height: 80,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 30,
              child: Container(
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(163, 119, 255, 0.4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(218, 0, 255, 1),
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 16,
                        left: 24,
                        child: Text(title,
                            style: Theme.of(context).textTheme.headlineSmall)),
                    Positioned(
                        top: 16,
                        right: 24,
                        child: Text(price,
                            style: Theme.of(context).textTheme.headlineSmall)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 60,
              child: Container(
                height: 20,
                width: 50,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(218, 0, 255, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text('Best',
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: Colors.white,
                            fontWeightDelta: 2,
                          )),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 80,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 30,
              child: Container(
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(163, 119, 255, 0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 16,
                        left: 24,
                        child: Text(title,
                            style: Theme.of(context).textTheme.headlineSmall)),
                    Positioned(
                        top: 16,
                        right: 24,
                        child: Text(price,
                            style: Theme.of(context).textTheme.headlineSmall)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
