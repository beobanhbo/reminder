import 'package:hive/hive.dart';
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

  WorkHive({
    this.id,
    this.title,
    this.createAt,
    this.stage,
    this.workType,
    this.workChildMap,
  });

  Work toOrigin() {
    return Work(
      id: id ?? "0",
      title: title ?? "",
      createAt: createAt ?? "",
      stage: stage ?? 0,
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
  }
}
