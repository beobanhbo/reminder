import 'package:reminder/model/work_hive.dart';

class Work {
  final String id, title, createAt;
  int stage;
  DateTime remindAtTime;
  bool enableReminder, isRepeat;
  WorkTypeHive workType;
  Map<String, Work> workChildMap;
  Week week;
  Work({
    this.id,
    this.title,
    this.createAt,
    this.remindAtTime,
    this.stage,
    this.enableReminder = false,
    this.isRepeat = false,
    this.week,
    this.workType,
    this.workChildMap,
  });
  WorkHive toHive() {
    return WorkHive(
      id: id ?? "0",
      title: title ?? "",
      createAt: createAt ?? "",
      stage: stage ?? 0,
      remindAtTime: remindAtTime ?? DateTime(1969, 1, 20, 7, 0, 0),
      enableReminder: enableReminder ?? false,
      isRepeat: isRepeat ?? false,
      week: week != null ? week.toHive() : [],
      workChildMap: workChildMap == null
          ? {}
          : Map.fromEntries(
              workChildMap.entries.map(
                (entries) => MapEntry(entries.key, entries.value.toHive()),
              ),
            ),
      workType: workType ?? WorkTypeHive.DAILY,
    );
  }
}

enum WorkType { DAILY, PLAN }
enum ScreenType { ADD_WORK, EDIT_WORK }

class Week {
  List<DayOfWeek> listDay;

  Week({this.listDay});
  WeekHive toHive() {
    return WeekHive(
        listDay: listDay.isEmpty
            ? []
            : listDay.map((entries) => entries.toHive()).toList());
  }
}

class DayOfWeek {
  final String dayName;
  bool isSelected;
  final int index;
  DayOfWeek({this.dayName, this.isSelected, this.index});
  DayOfWeekHive toHive() {
    return DayOfWeekHive(
      dayName: dayName ?? "",
      isSelected: isSelected ?? false,
      index: index ?? 0,
    );
  }
}

class WorkBlock {
  Map<String, Work> workBlockMap;

  WorkBlock({this.workBlockMap});

  WorkBlockHive toHive() {
    return WorkBlockHive(
      workBlockHiveMap: workBlockMap == null
          ? {}
          : Map.fromEntries(
              workBlockMap.entries.map(
                (entries) => MapEntry(entries.key, entries.value.toHive()),
              ),
            ),
    );
  }
}

class SavedPendingNotificationID {
  final Map<int, List<int>> mapPendingID;

  SavedPendingNotificationID({this.mapPendingID});
  SavedPendingNotificationIDHive toHive() {
    return SavedPendingNotificationIDHive(
        mapPendingID: this.mapPendingID ?? {});
  }
}
