import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static const String daily = 'assets/images/daily_1.svg';
  static const String plan = 'assets/images/plan.svg';
  static const String ic_delete_group = 'assets/images/ic_delete_group.svg';
  static const String ic_edit = 'assets/images/ic_edit.svg';
  static const String ic_check = 'assets/images/ic_check.svg';
  static const String icSuccessfully = 'assets/images/ic_successfully.svg';
  static const String icError = 'assets/images/ic_error.svg';
  static const String ic_undo_alt_blue = 'assets/images/ic_undo_alt_blue.svg';
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
