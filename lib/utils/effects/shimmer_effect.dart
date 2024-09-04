import 'package:flutter/material.dart';
import 'package:lyrica_ver2/utils/helpers/helpers.dart';
import 'package:shimmer/shimmer.dart';



class ShimmerEffect extends StatelessWidget {
  ShimmerEffect(
      {Key? key,
      required this.height,
      required this.width,
      this.radius,
      this.color})
      : super(key: key);

  final double width, height;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color ?? (dark ? Colors.grey : Colors.white),
            borderRadius: BorderRadius.circular(radius ?? 0),
          )),
    );
  }
}
