import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:reminder/common/app_manager.dart';
import 'package:reminder/model/work.dart';
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
    } else if (event is AddNewWorkEvent) {
      yield* _mapEventAddWork(event);
    } else if (event is UpdateWorkEvent) {
      yield* _mapEventUpdateWork(event);
    } else if (event is DeleteWorkEvent) {
      yield* _mapEventDeleteWork(event);
    }
  }

  Stream<MainScreenState> _mapEventFetchData(FetchDataEvent event) async* {
    try {
      await AppUtils.openBox();
      (await Hive.openBox<WorkBlockHive>('workBlocHive')).add(WorkBlockHive());

      WorkBlockHive workBlockHive =
          Hive.box<WorkBlockHive>('workBlocHive').getAt(0);

      initializeDateFormatting('en', null);

      final List<String> listDays =
          DateFormat.EEEE(Platform.localeName).dateSymbols.SHORTWEEKDAYS;
      Week week = Week(
          listDay: listDays
              .map((entries) => DayOfWeek(dayName: entries, isSelected: false))
              .toList());
      AppManager.shared.week = week;
      yield FetchDataSuccess(workBlockHive: workBlockHive);
    } catch (e) {}
  }

  Stream<MainScreenState> _mapEventAddWork(AddNewWorkEvent event) async* {
    final workBox = Hive.box<WorkBlockHive>('workBlocHive');
    if (workBox.isNotEmpty) {
      WorkBlockHive workBlockHive = workBox.getAt(0);
      workBlockHive.addWork(event.work);
      workBlockHive.save();

      yield FetchDataSuccess(workBlockHive: workBlockHive);
    }
  }

  Stream<MainScreenState> _mapEventUpdateWork(UpdateWorkEvent event) async* {
    final workBox = Hive.box<WorkBlockHive>('workBlocHive');
    if (workBox.isNotEmpty) {
      WorkBlockHive workBlockHive = workBox.getAt(0);
      workBlockHive.updateWork(event.work);
      if (event.work.stage == 1) {
        AppUtils.bringWorkToLast(event.work);
      }
      workBlockHive.save();

      yield FetchDataSuccess(workBlockHive: workBlockHive);
    }
  }

  Stream<MainScreenState> _mapEventDeleteWork(DeleteWorkEvent event) async* {
    final workBox = Hive.box<WorkBlockHive>('workBlocHive');
    if (workBox.isNotEmpty) {
      WorkBlockHive workBlockHive = workBox.getAt(0);
      workBlockHive.deleteWork(event.workID);
      workBlockHive.save();

      yield FetchDataSuccess(workBlockHive: workBlockHive);
    }
  }
}
