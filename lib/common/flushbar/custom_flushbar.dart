import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_assets.dart';
import 'package:reminder/config/app_font_styles.dart';

enum AlertType { error, success }

class CustomFlushBar {
  final BuildContext context;
  final String title;
  final String message;
  final AlertType alertType;

  CustomFlushBar({this.context, this.title, this.message, this.alertType});
  void showFlushBar() {
    Flushbar(
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: AppColors.white,
      messageText: Text(message, style: AppStyles.textStyleBlackNormal(16)),
      icon: Container(
          width: 60.0,
          height: 40.0,
          child: Center(
              child: AppImages.asset(
                  assetPath: (alertType == AlertType.success)
                      ? AppAssets.icSuccessfully
                      : AppAssets.icError,
                  height: 30,
                  width: 30))),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
    )..show(context);
  }
}
