import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomImage extends StatelessWidget {
  String image;
  double width;
  double height;
  BoxFit? fit;
  Color? color;

  CustomImage(
      {super.key,
      required this.image,
      required this.width,
      required this.height,
      this.fit = BoxFit.contain,
      this.color});

  @override
  Widget build(BuildContext context) {
    return kIsWeb == true
        ? Image.network(
            "assets/$image",
            width: width,
            height: height,
            fit: fit,
            color: color,
          )
        : Image.asset(
            image,
            width: width,
            height: height,
            fit: fit,
            color: color,
          );
  }
}
