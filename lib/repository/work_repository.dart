import 'package:reminder/model/work.dart';
import 'package:reminder/model/work_hive.dart';

class WorkRepository {
  Future<WorkBlock> mockWorkBloc() async {
    Work work1 = Work(
      id: "0",
      title: "Task 1",
      createAt: "1234514",
      stage: 0,
      workType: WorkTypeHive.DAILY,
    );
    Work work2 = Work(
      id: "0",
      title: "Task 2",
      createAt: "123451434",
      stage: 0,
      workType: WorkTypeHive.DAILY,
    );
    List<Work> listWork = [];
    listWork.add(work1);
    listWork.add(work2);
    Map<String, Work> map = {};
    listWork.forEach((element) {
      map['${element.id}'] = element;
    });
    WorkBlock workBlock = WorkBlock(workBlockMap: map);
    return workBlock;
  }
}
