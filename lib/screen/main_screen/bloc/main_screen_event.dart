import 'package:reminder/model/work.dart';

abstract class MainScreenEvent {}

class FetchDataEvent extends MainScreenEvent {}

class AddNewWorkEvent extends MainScreenEvent {
  final Work work;

  AddNewWorkEvent(this.work);
}

class UpdateWorkEvent extends MainScreenEvent {
  final Work work;

  UpdateWorkEvent(this.work);
}

class DeleteWorkEvent extends MainScreenEvent {
  final String workID;

  DeleteWorkEvent(this.workID);
}
