import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder/config/CustomAppTheme.dart';
import 'package:reminder/routes.dart';

void main() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
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
