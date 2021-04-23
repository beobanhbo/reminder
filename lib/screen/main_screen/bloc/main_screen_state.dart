import 'package:reminder/model/work_hive.dart';

abstract class MainScreenState {}

class FetchDataSuccess extends MainScreenState {
  final WorkBlockHive workBlockHive;

  FetchDataSuccess({this.workBlockHive});
}

class MainScreenInit extends MainScreenState {}
