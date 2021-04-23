import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_bloc.dart';
import 'package:reminder/screen/main_screen/main_screen.dart';

class Routes {
  static const String Main_Screen = '/home';
  CupertinoPageRoute getRoutes(RouteSettings settings) {
    return CupertinoPageRoute(
        settings: settings,
        builder: (context) {
          switch (settings.name) {
            case Main_Screen:
              return BlocProvider(
                  create: (context) => MainScreenBloc(), child: MainScreen());
            default:
              return Container();
          }
        });
  }
}
