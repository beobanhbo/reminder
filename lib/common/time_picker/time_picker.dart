import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Color, Colors, GestureDetector;
import 'package:flutter/cupertino.dart'
    show
        Alignment,
        Border,
        BorderSide,
        BoxDecoration,
        BuildContext,
        Color,
        Column,
        Container,
        CrossAxisAlignment,
        CupertinoDatePicker,
        CupertinoTextThemeData,
        CupertinoTheme,
        CupertinoThemeData,
        EdgeInsets,
        Expanded,
        FontWeight,
        Key,
        MainAxisAlignment,
        Navigator,
        Row,
        SizedBox,
        Text,
        Widget,
        required,
        showCupertinoModalPopup;
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/config/app_strings.dart';
export 'package:flutter/material.dart' show Color, Colors;

void showTimesPicker(BuildContext context,
    {Key key,
    @required Function(DateTime value) onDateTimeChanged,
    int minuteInterval = 1,
    Color backgroundColor,
    bool useRootNavigator = true,
    DateTime initDateTime}) {
  backgroundColor = backgroundColor ?? AppColors.white;
  DateTime dateTime;
  // Default to right now.

  var doneButton = GestureDetector(
      onTap: () {
        onDateTimeChanged(dateTime);
        Navigator.of(context).pop();
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Text(
            AppStrings.Done,
            style: CupertinoTheme.of(context)
                .textTheme
                .actionTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          )));

  //
  showCupertinoModalPopup(
    context: context,
    builder: (context) => SizedBox(
      height: 240.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: const BorderSide(width: 0.5, color: Colors.black38),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                doneButton,
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: AppColors.white,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: AppStyles.textStyleBlackNormal(21),
                    pickerTextStyle: AppStyles.textStyleBlackNormal(21)),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                minimumYear: initDateTime.year,
                onDateTimeChanged: (DateTime value) {
                  if (onDateTimeChanged == null) return;

                  dateTime = DateTime(value.year, value.month, value.day,
                      value.hour, value.minute);
                },
                initialDateTime: initDateTime,
                minuteInterval: minuteInterval,
                use24hFormat: true,
                backgroundColor: backgroundColor,
              ),
            ),
          ))
        ],
      ),
    ),
    useRootNavigator: useRootNavigator,
  );
}
