import 'package:flutter/cupertino.dart';
import 'package:reminder/config/AppColors.dart';

class AppStyles {
  static TextStyle textStyleBlackNormal(double textSize) {
    return TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: textSize,
        color: AppColors.black);
  }

  static TextStyle textStyleBlackBold(double textSize) {
    return TextStyle(
      fontSize: textSize,
      color: AppColors.black,
    );
  }

  static TextStyle textStyleWhite(double textSize) {
    return TextStyle(
      fontSize: textSize,
      color: AppColors.white,
    );
  }
}
