import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:reminder/model/work_hive.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_event.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_state.dart';

import '../../../common/app_utils.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenInit());

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchDataEvent) {
      yield* _mapEventFetchData(event);
    }
  }

  Stream<MainScreenState> _mapEventFetchData(FetchDataEvent event) async* {
    try {
      await AppUtils.openBox();
      (await Hive.openBox<WorkBlockHive>('workBlocHive')).add(WorkBlockHive());

      WorkBlockHive workBlockHive =
          Hive.box<WorkBlockHive>('workBlocHive').getAt(0);
      yield FetchDataSuccess(workBlockHive: workBlockHive);
    } catch (e) {}
  }
}
