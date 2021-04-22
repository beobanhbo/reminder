import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static final String daily = 'assets/images/daily_1.svg';
  static final String plan = 'assets/images/plan.svg';
}

class AppImages {
  static Widget asset(
      {@required String assetPath,
      Color color,
      bool isXor = false,
      BoxFit fit = BoxFit.fill,
      double width,
      double height}) {
    if (assetPath.contains('.svg'))
      return SvgPicture.asset(
        assetPath,
        colorBlendMode: (isXor ?? false) ? BlendMode.luminosity : null,
        fit: fit,
        width: width,
        height: height,
        color: color ?? null,
      );
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      color: color ?? null,
    );
  }
}
