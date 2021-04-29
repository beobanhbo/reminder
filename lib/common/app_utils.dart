import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:reminder/model/work.dart';
import 'package:reminder/model/work_hive.dart';
import 'package:reminder/config/push_notification.dart';

class AppUtils {
  static BoxDecoration gradientBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.pink[50], Colors.blue[100]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight));
  }

  static Future<void> openBox({int i = 0}) async {
    if (i > 3) return;
    try {
      await Future.wait([
        Hive.openBox<WorkBlockHive>('workBlocHive'),
        Hive.openBox<SavedPendingNotificationIDHive>(
            'SavedPendingNotificationIDHive')
      ]);
    } catch (e) {
      await Future.wait([
        Hive.deleteBoxFromDisk('workBlocHive'),
        Hive.openBox<SavedPendingNotificationIDHive>(
            'SavedPendingNotificationIDHive')
      ]);
      return await openBox(i: ++i);
    }
  }

  static void bringWorkToLast(Work work) {
    final workBox = Hive.box<WorkBlockHive>('workBlocHive');
    if (workBox.isNotEmpty) {
      WorkBlockHive workBlockHive = workBox.getAt(0);
      workBlockHive.workBlockHiveMap.remove(work.id);

      List<WorkHive> list = workBlockHive.workBlockHiveMap.values.toList();
      list.insert(0, work.toHive());

      workBlockHive.workBlockHiveMap = Map.fromIterable(list,
          key: (entries) => entries.id, value: (entries) => entries);
      workBlockHive.save();
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

  static int generateWorkID(int workID, int index) {
    String id = '$workID$index';
    return int.parse(id);
  }

  static void saveNotificationID(int workID, int notificationID) async {
    final savedNotification = Hive.box<SavedPendingNotificationIDHive>(
        'SavedPendingNotificationIDHive');
    if (savedNotification.isNotEmpty) {
      SavedPendingNotificationIDHive savedPending = savedNotification.getAt(0);
      // savedPending.mapPendingID[workID].add(notificationID);
      savedPending.addNotification(workID, notificationID);
      savedPending.save();
    }
  }

  static void turnOffPendingNotificationByID(int workID, int notificationID) {
    final savedNotification = Hive.box<SavedPendingNotificationIDHive>(
        'SavedPendingNotificationIDHive');
    if (savedNotification.isNotEmpty) {
      SavedPendingNotificationIDHive savedPending = savedNotification.getAt(0);
      if (savedPending?.mapPendingID[workID] != null &&
          savedPending.mapPendingID[workID].isNotEmpty) {
        if (workID == notificationID) {
          savedPending.mapPendingID.remove(workID);
          turnOffNotification(workID);
          savedPending.save();
        } else {
          final id = savedPending.mapPendingID[workID].firstWhere(
              (element) => element != notificationID,
              orElse: () => null);
          if (id != null) {
            savedPending.mapPendingID[workID].remove(id);
            if (savedPending.mapPendingID[workID].isEmpty)
              savedPending.mapPendingID.remove(workID);
            turnOffNotification(id);
            savedPending.save();
          }
        }
      }
    }
  }

  static void turnOffAllPendingNotification() {
    turnOffAllNotification();

    final savedNotification = Hive.box<SavedPendingNotificationIDHive>(
        'SavedPendingNotificationIDHive');
    if (savedNotification.isNotEmpty) {
      SavedPendingNotificationIDHive savedPending = savedNotification.getAt(0);
      if (savedPending?.mapPendingID != null &&
          savedPending.mapPendingID.isNotEmpty) {
        savedPending.mapPendingID.clear();
        savedPending.save();
      }
    }
  }

  static List<String> getListDaysOfWeek() {
    final List<String> listDays =
        DateFormat.EEEE(Platform.localeName).dateSymbols.SHORTWEEKDAYS;
    List<String> listCopy = List.of(listDays);
    final String sun = listDays.first;
    listCopy.removeAt(0);
    listCopy.insert(listCopy.length, sun);
    return listCopy;
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

    return hhmma;
  }

  static bool isNewDay(DateTime latestDate, DateTime currentDate) {
    return currentDate.difference(latestDate).inDays > 0 ? true : false;
  }

  static String formatTime(String datetime, String dateFormat) {
    String result = "";
    try {
      result =
          DateFormat(dateFormat).format(DateTime.parse(datetime).toLocal());
    } catch (e) {}
    return result;
  }

  static String microSecondToDate(int microsecond, {String format}) {
    String dateTime =
        DateTime.fromMicrosecondsSinceEpoch(microsecond).toString();
    String dateFormat = formatTime(dateTime, format ?? 'yyyy-MM-dd HH:mm');
    return dateFormat;
  }
}
