import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/config/app_strings.dart';
import 'package:reminder/model/work.dart';

class AlertUtil {
  static Future showDialogAlert(
      {@required BuildContext context,
      @required String message,
      @required String title,
      String leftTitle,
      Work work,
      VoidCallback onConfirm,
      VoidCallback onCancel,
      String rightTitle}) async {
    CustomAlertDialog customAlertDialog = CustomAlertDialog(
        context: context,
        message: message ?? "",
        leftTitle: leftTitle ?? AppStrings.Confirm,
        rightTitle: rightTitle ?? AppStrings.Cancel,
        title: title ?? AppStrings.Alert,
        work: work,
        onConfirm: onConfirm,
        onCancel: onCancel);

    return await showDialog(
        context: context, builder: (context) => customAlertDialog.openDialog());
  }
}

class CustomAlertDialog {
  final BuildContext context;
  final String message, title, leftTitle, rightTitle;
  final Work work;
  final VoidCallback onConfirm, onCancel;

  CustomAlertDialog(
      {this.context,
      this.message,
      this.leftTitle,
      this.rightTitle,
      this.title,
      this.work,
      this.onConfirm,
      this.onCancel});

  Widget openDialog() {
    if (Platform.isIOS) {
      return _buildIOSDialog();
    } else {
      return _buildAndroidDialog();
    }
  }

  Widget _buildIOSDialog() {
    List<Widget> actionWidgets = [];
    actionWidgets.add(
      CupertinoDialogAction(
        child: Text(leftTitle),
        onPressed: _onConfirm,
      ),
    );
    if (rightTitle != null && onCancel != null) {
      actionWidgets.add(
        CupertinoDialogAction(
          child: Text(rightTitle),
          onPressed: _onCancel,
        ),
      );
    }
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actionWidgets,
    );
  }

  Widget _buildAndroidDialog() {
    List<Widget> actionWidgets = [];
    actionWidgets.add(
      CupertinoDialogAction(
        child: Text(leftTitle),
        onPressed: _onConfirm,
      ),
    );
    if (rightTitle != null && onCancel != null) {
      actionWidgets.add(
        CupertinoDialogAction(
          child: Text(rightTitle),
          onPressed: _onCancel,
        ),
      );
    }
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actionWidgets,
    );
  }

  _onCancel() {
    if (onCancel != null) onCancel();
    Navigator.pop(context, false);
  }

  _onConfirm() {
    if (onConfirm != null) onConfirm();
    Navigator.pop(context, false);
  }
}
