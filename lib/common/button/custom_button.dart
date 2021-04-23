import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/config/app_strings.dart';

class CustomButton extends StatelessWidget {
  final String title, icon;
  final double height, width;
  final Color backGroundColor;
  final Widget widget;
  final Function onTap;

  CustomButton(
    this.title,
    this.icon,
    this.height,
    this.width,
    this.widget,
    this.onTap,
    this.backGroundColor,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: backGroundColor != null ? backGroundColor : AppColors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonBar(
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(
                    Icons.check,
                    color: AppColors.white,
                  ),
                  onPressed: () {},
                  label: Text(
                    title.isNotEmpty ? title : AppStrings.Done,
                    style: AppStyles.textStyleWhite(16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
