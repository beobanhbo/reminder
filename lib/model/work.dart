import 'package:reminder/model/work_hive.dart';

class Work {
  final String id, title, createAt;
  int stage;
  WorkTypeHive workType;
  Map<String, Work> workChildMap;
  Work({
    this.id,
    this.title,
    this.createAt,
    this.stage,
    this.workType,
    this.workChildMap,
  });
  WorkHive toHive() {
    return WorkHive(
      id: id ?? "0",
      title: title ?? "",
      createAt: createAt ?? "",
      stage: stage ?? 0,
      workChildMap: workChildMap == null
          ? {}
          : Map.fromEntries(workChildMap.entries
              .map((entries) => MapEntry(entries.key, entries.value.toHive()))),
      workType: workType ?? WorkTypeHive.DAILY,
    );
  }
}

enum WorkType { DAILY, PLAN }

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
