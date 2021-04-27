import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/model/work.dart';
import 'package:reminder/model/work_hive.dart';

class AppUtils {
  static BoxDecoration gradientBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.pink[50], Colors.blue[100]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight));
  }

  static BoxDecoration boxDecorationCornerLeft() {
    return BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)));
  }

  static BoxDecoration boxDecorationCornerRight() {
    return BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)));
  }

  static Future<void> openBox({int i = 0}) async {
    if (i > 3) return;
    try {
      await Future.wait([Hive.openBox<WorkBlockHive>('workBlocHive')]);
    } catch (e) {
      await Future.wait([Hive.deleteBoxFromDisk('workBlocHive')]);
      return await openBox(i: ++i);
    }
  }

  static List<Work> getListWork(WorkBlockHive workBlockHive) {
    List<Work> list = [];
    if (workBlockHive.workBlockHiveMap != null)
      workBlockHive.workBlockHiveMap.values.forEach((element) {
        list.add(element.toOrigin());
      });

    return list;
  }

  static List<String> getChoosedDayName(List<DayOfWeek> listDay) {
    List<String> lsString = [];

    listDay.forEach((element) {
      if (element.isSelected) {
        if (lsString.length >= 1) lsString.add(',');

        lsString.add(element.dayName);
      } else
        lsString.remove(element.dayName);
    });

    return lsString;
  }

  static String convertFormatDateTime(DateTime dateTime) {
    String hhmma = DateFormat.jm().format(dateTime);
    // DateTime result = DateTime.parse(dateTime.toString());
    // TimeOfDay.hoursPerDay
    return hhmma;
  }
}
