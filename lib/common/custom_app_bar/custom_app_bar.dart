import 'package:flutter/material.dart';
import 'package:reminder/config/AppColors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Widget leftButtonWidget;
  final Color backgroundColor;
  final bool centerTitle, autoLeading;

  CustomAppBar(
      {this.title,
      this.leftButtonWidget,
      this.backgroundColor,
      this.centerTitle,
      this.autoLeading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: autoLeading ?? true,
      title: Text(
        title ?? "",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.black),
      ),
      centerTitle: centerTitle ?? true,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      leading: (leftButtonWidget != null) ? leftButtonWidget : null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
