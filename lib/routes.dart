import 'package:flutter/cupertino.dart';
import 'package:reminder/screen/main_screen.dart';

class Routes {
  static const String Main_Screen = '/home';
  CupertinoPageRoute getRoutes(RouteSettings settings) {
    return CupertinoPageRoute(
        settings: settings,
        builder: (context) {
          switch (settings.name) {
            case Main_Screen:
              return MainScreen();
            default:
              return Container();
          }
        });
  }
}
