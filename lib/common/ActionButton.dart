import 'package:flutter/material.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_assets.dart';

class ActionButton extends StatefulWidget {
  final Function onTap;
  final String title, iconPath;
  final Color backgroundColor, borderColor, titleColor;
  const ActionButton(
      {Key key,
      this.onTap,
      this.title,
      this.iconPath,
      this.titleColor,
      this.backgroundColor,
      this.borderColor})
      : super(key: key);
  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 44,
        padding: EdgeInsets.fromLTRB(8, 12.5, 8, 12.5),
        constraints: BoxConstraints(minWidth: 130),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: widget.backgroundColor ?? AppColors.white,
            border:
                Border.all(color: widget.borderColor ?? Colors.transparent)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.iconPath != null
                ? Container(
                    margin: EdgeInsets.only(right: 8),
                    child: AppImages.asset(
                        assetPath: widget.iconPath, height: 16, width: 16))
                : Container(),
            Text(
              widget.title,
              style: TextStyle(
                color: widget.titleColor ?? AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
