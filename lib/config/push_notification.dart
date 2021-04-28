import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:reminder/config/app_strings.dart';
import 'package:reminder/model/work.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

class NotificationClass {
  final int id;
  String title, body, payload;

  NotificationClass({this.id, this.title, this.body, this.payload});
}

BehaviorSubject<NotificationClass> didReceive =
    BehaviorSubject<NotificationClass>();
BehaviorSubject<String> behaviorSubject = BehaviorSubject<String>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initLocalNotification() async {
  var initAllPlatformSetting = InitializationSettings(
    android: AndroidInitializationSettings('ic_launcher'),
    iOS: IOSInitializationSettings(onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async {
      didReceive.add(NotificationClass(
          id: id, title: title, body: body, payload: payload));
    }),
  );
  flutterLocalNotificationsPlugin.initialize(initAllPlatformSetting,
      onSelectNotification: (String payload) async {
    behaviorSubject.add(payload);
  });
}

void requestIOSPermission(FlutterLocalNotificationsPlugin plugin) async {
  plugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(sound: true, alert: true, badge: true);
}

Future<void> scheduleNotification(FlutterLocalNotificationsPlugin plugin,
    DateTime dateTime, NotificationClass notificationClass,
    {List<DayOfWeek> listDayOfWeek}) async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    notificationClass.id.toString(),
    AppStrings.SetRemind,
    '${AppStrings.TaskRemind} ${notificationClass.title}',
  );
  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: iosNotificationDetails,
  );
  if (listDayOfWeek != null) {
    for (var item in listDayOfWeek) {
      if (item.isSelected) {
        final day = _nextInstanceOfDayAndTime(
            dateTime.hour, dateTime.minute, item.index);

        await plugin.zonedSchedule(
          notificationClass.id + Random().nextInt(100),
          notificationClass.title,
          day.toString(),
          day,
          notificationDetails,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    }
  } else
    await plugin.zonedSchedule(
        notificationClass.id,
        notificationClass.title,
        notificationClass.payload,
        _nextInstanceOfSpecifiedTime(dateTime.hour, dateTime.minute),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
}

TZDateTime _nextInstanceOfSpecifiedTime(int hour, int minute) {
  TZDateTime now = TZDateTime.now(local);
  TZDateTime scheduleTime =
      TZDateTime(local, now.year, now.month, now.day, hour, minute);
  if (scheduleTime.isBefore(now))
    scheduleTime = scheduleTime.add(Duration(days: 1));
  return scheduleTime;
}

TZDateTime _nextInstanceOfDayAndTime(int hour, int minute, int dayIndex) {
  TZDateTime scheduleDay = _nextInstanceOfSpecifiedTime(hour, minute);

  while (scheduleDay.weekday != dayIndex) {
    scheduleDay = scheduleDay.add(Duration(days: 1));
  }
  return scheduleDay;
}

Future turnOffNotification(
    FlutterLocalNotificationsPlugin plugin, int id) async {
  await plugin.cancel(id);
}

Future<void> configureLocalTimeZone() async {
  initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  setLocalLocation(getLocation(timeZoneName));
}
