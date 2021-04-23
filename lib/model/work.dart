import 'package:reminder/model/work_hive.dart';

class Work {
  final String id, title, createAt;
  int stage;
  WorkTypeHive workType;
  Work({
    this.id,
    this.title,
    this.createAt,
    this.stage,
    this.workType,
  });
  WorkHive toHive() {
    return WorkHive(
      id: id ?? "0",
      title: title ?? "",
      createAt: createAt ?? "",
      stage: stage ?? 0,
      workType: workType ?? WorkType.DAILY,
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
