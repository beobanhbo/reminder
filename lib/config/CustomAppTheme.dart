import 'package:flutter/material.dart';

import 'AppColors.dart';

class CustomAppTheme {
  static ThemeData themeData = ThemeData(
      brightness: Brightness.light,
      backgroundColor: AppColors.white,
      primaryColor: AppColors.white,
      appBarTheme: AppBarTheme(color: AppColors.blue),
      textTheme: TextTheme(
          headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
}
