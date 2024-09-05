
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PlaylistCard extends StatelessWidget {
  double height;
  double width;
  String image;
  String name;
  PlaylistCard(
      {super.key, required this.height,
      required this.width,
      required this.image,
      required this.name});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: SizedBox(
            height: 40,
            width: 160,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
