import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder/config/CustomAppTheme.dart';
import 'package:reminder/model/work_hive.dart';
import 'package:reminder/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(WorkBlockHiveAdapter());
  Hive.registerAdapter(WorkHiveAdapter());
  Hive.registerAdapter(WorkTypeHiveAdapter());
  Hive.registerAdapter(WeekHiveAdapter());
  Hive.registerAdapter(DayOfWeekHiveAdapter());
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
