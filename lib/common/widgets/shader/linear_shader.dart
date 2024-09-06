import 'package:flutter/material.dart';

ShaderMask buildShaderMask(Widget child) {
  return ShaderMask(
    shaderCallback: (Rect bounds) {
      return const LinearGradient(
        colors: [
           Color.fromRGBO(106, 53, 219, 1),
          Color.fromRGBO(195, 71, 216, 1),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds);
    },
    child: child,
  );
}
