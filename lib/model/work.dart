import 'package:reminder/model/work_hive.dart';

class Work {
  final String id, title, createAt;
  int stage;
  String remindAtDate;
  bool enableReminder;
  WorkTypeHive workType;
  Map<String, Work> workChildMap;
  Week week;
  Work({
    this.id,
    this.title,
    this.createAt,
    this.remindAtDate,
    this.stage,
    this.enableReminder = false,
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
      enableReminder: enableReminder ?? false,
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

  DayOfWeek({this.dayName, this.isSelected});
  DayOfWeekHive toHive() {
    return DayOfWeekHive(
      dayName: dayName ?? "",
      isSelected: isSelected ?? false,
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
