import 'package:flutter/material.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_assets.dart';

class CustomIconButton extends StatefulWidget {
  final Function onTap;
  final String title, iconPath;
  final Color backgroundColor, borderColor, titleColor;
  const CustomIconButton(
      {Key key,
      this.onTap,
      this.title,
      this.iconPath,
      this.titleColor,
      this.backgroundColor,
      this.borderColor})
      : super(key: key);
  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 44,
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(minWidth: 44, maxWidth: 44),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.backgroundColor ?? AppColors.white,
            border:
                Border.all(color: widget.borderColor ?? Colors.transparent)),
        child: widget.iconPath != null
            ? Center(
                child: Container(
                    child: AppImages.asset(
                        assetPath: widget.iconPath,
                        isXor: true,
                        height: 16,
                        width: 16)),
              )
            : Container(),
      ),
    );
  }
}
