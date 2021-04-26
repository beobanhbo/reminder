import 'package:reminder/model/work.dart';

class AppManager {
  AppManager._interval();
  Week week;
  static final shared = AppManager._interval();
  factory AppManager() => shared;
}
