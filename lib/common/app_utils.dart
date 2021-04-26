import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

  static String getChoosedDayName(String dayName, String stringName) {
    String name = stringName;
    if (name.contains(dayName)) name.replaceFirst(dayName, '');
    return name;
  }
}
