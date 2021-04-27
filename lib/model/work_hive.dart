import 'package:hive/hive.dart';
import 'package:reminder/common/app_manager.dart';
import 'package:reminder/common/app_utils.dart';
import 'package:reminder/model/work.dart';
part 'work_hive.g.dart';

@HiveType(typeId: 0)
class WorkHive extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String createAt;
  @HiveField(3)
  int stage;
  @HiveField(4)
  WorkTypeHive workType;
  @HiveField(5)
  Map<String, WorkHive> workChildMap;
  @HiveField(6)
  WeekHive week;
  @HiveField(7)
  bool enableReminder;
  @HiveField(8)
  bool isRepeat;
  @HiveField(9)
  DateTime remindAtTime;

  WorkHive({
    this.id,
    this.title,
    this.createAt,
    this.stage,
    this.remindAtTime,
    this.enableReminder = false,
    this.isRepeat = false,
    this.week,
    this.workType,
    this.workChildMap,
  });

  Work toOrigin() {
    return Work(
      id: id ?? "0",
      title: title ?? "",
      createAt: createAt ?? "",
      stage: stage ?? 0,
      remindAtTime: remindAtTime ?? DateTime(1969, 1, 20, 7, 0, 0),
      enableReminder: enableReminder ?? false,
      isRepeat: isRepeat ?? false,
      week: week != null ? week.toOrigin() : [],
      workChildMap: workChildMap == null
          ? {}
          : Map.fromEntries(workChildMap.entries.map(
              (entries) => MapEntry(entries.key, entries.value.toOrigin()))),
      workType: workType ?? WorkTypeHive.DAILY,
    );
  }
}

@HiveType(typeId: 1)
enum WorkTypeHive {
  @HiveField(0)
  DAILY,
  @HiveField(1)
  PLAN
}

@HiveType(typeId: 2)
class WorkBlockHive extends HiveObject {
  @HiveField(0)
  Map<String, WorkHive> workBlockHiveMap;

  WorkBlockHive({this.workBlockHiveMap});
  WorkBlock toOrigin() {
    return WorkBlock(
      workBlockMap: workBlockHiveMap == null
          ? {}
          : Map.fromEntries(
              workBlockHiveMap.entries.map(
                (entries) => MapEntry(entries.key, entries.value.toOrigin()),
              ),
            ),
    );
  }

  void addWork(Work work) {
    workBlockHiveMap ??= {};
    workBlockHiveMap.putIfAbsent(work.id, () => work.toHive());
    AppManager.shared.latestDate =
        DateTime.parse(AppUtils.microSecondToDate(int.parse(work.id)));
  }

  void updateWork(Work work) {
    workBlockHiveMap.update(work.id, (workHive) => work.toHive());
  }

  void deleteWork(String workID) {
    workBlockHiveMap.removeWhere((key, value) => key == workID);
  }
}

@HiveType(typeId: 3)
class DayOfWeekHive extends HiveObject {
  @HiveField(0)
  String dayName;
  @HiveField(1)
  bool isSelected;

  DayOfWeekHive({this.dayName, this.isSelected});
  DayOfWeek toOrigin() {
    return DayOfWeek(dayName: dayName ?? "", isSelected: isSelected ?? false);
  }
}

@HiveType(typeId: 4)
class WeekHive extends HiveObject {
  @HiveField(0)
  List<DayOfWeekHive> listDay;

  WeekHive({this.listDay});
  Week toOrigin() {
    return Week(
      listDay: listDay.isEmpty
          ? []
          : listDay.map((entries) => entries.toOrigin()).toList(),
    );
  }
}
