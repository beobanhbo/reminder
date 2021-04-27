import 'package:reminder/model/work.dart';

class AppManager {
  AppManager._interval();
  Week week;
  DateTime latestDate;
  static final shared = AppManager._interval();
  factory AppManager() => shared;
}
