import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder/config/CustomAppTheme.dart';
import 'package:reminder/model/work_hive.dart';
import 'package:reminder/routes.dart';

import 'config/push_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureLocalTimeZone();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationAppLaunchDetails notificationAppLaunchDetails;

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WorkBlockHiveAdapter());
  Hive.registerAdapter(WorkHiveAdapter());
  Hive.registerAdapter(WorkTypeHiveAdapter());
  Hive.registerAdapter(WeekHiveAdapter());
  Hive.registerAdapter(DayOfWeekHiveAdapter());
  Hive.registerAdapter(SavedPendingNotificationIDHiveAdapter());

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initLocalNotification();
  requestIOSPermission(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = Routes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomAppTheme.themeData,
      initialRoute: Routes.Main_Screen,
      onGenerateRoute: (setting) => routes.getRoutes(setting),
    );
  }
}
