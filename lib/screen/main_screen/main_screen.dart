import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reminder/common/alert_dialog/alert_util.dart';
import 'package:reminder/common/app_utils.dart';
import 'package:reminder/common/slidable/slideable_work_item.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_assets.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/config/app_strings.dart';
import 'package:reminder/model/work.dart';
import 'package:reminder/screen/edit_work_screen/edit_work_screen.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_event.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_state.dart';

import '../../config/AppColors.dart';
import 'bloc/main_screen_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainScreenBloc _mainScreenBloc;
  List<Work> _listWork = [];
  final SlidableController slidableController = SlidableController();

  @override
  void initState() {
    _mainScreenBloc = BlocProvider.of<MainScreenBloc>(context);
    _mainScreenBloc.add(FetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _onOpenEditScreen();
          },
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: AppUtils.gradientBoxDecoration(),
            child: Column(
              children: [
                _buildCategory(),
                _buildListWork(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
              fit: FlexFit.tight,
              child: _buildButtonCategory(
                AppStrings.Daily,
                AppAssets.daily,
              )),
          SizedBox(
            width: 2,
            child: Container(
              width: 1,
              height: 40,
              color: AppColors.grey73,
            ),
          ),
          Flexible(
              fit: FlexFit.tight,
              child: _buildButtonCategory(
                AppStrings.Plan,
                AppAssets.plan,
              ))
        ],
      ),
    );
  }

  Widget _buildButtonCategory(String title, String path) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            AppImages.asset(assetPath: path, height: 40, width: 40),
            Text(
              title,
              style: AppStyles.textStyleBlackNormal(16),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListWork() {
    return BlocConsumer(
        bloc: _mainScreenBloc,
        buildWhen: (context, state) => state is FetchDataSuccess ? true : false,
        builder: (context, state) {
          return _listWork.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(top: 8, right: 4, left: 4),
                    child: SlideWorkItem(
                      work: _listWork[index],
                      slidableKey: Key(_listWork[index].id),
                      slidableController: slidableController,
                      onEdit: () {
                        _onOpenEditScreen(work: _listWork[index]);
                      },
                      onCheck: () {
                        _onTapCheck(_listWork[index]);
                      },
                      onDelete: () {
                        _onTapDelete(_listWork[index]);
                      },
                    ),
                  ),
                  itemCount: _listWork.length,
                )
              : _buildEmpTyItem();
        },
        listener: _handleFetchData);
  }

  Widget _buildEmpTyItem() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
            onTap: () {
              _onOpenEditScreen();
            },
            child: Container(
              child: Container(
                height: 250,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      size: 40,
                      color: AppColors.lightTextGrey,
                    ),
                    Text(
                      AppStrings.TapToAdd,
                      style: AppStyles.textStyleBlackNormal(16),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _handleFetchData(BuildContext context, state) {
    if (state is FetchDataSuccess) {
      _listWork = AppUtils.getListWork(state.workBlockHive);
    }
  }

  void _onOpenEditScreen({Work work}) {
    showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
              value: _mainScreenBloc,
              child: EditWorkScreen(
                _mainScreenBloc,
                work: work,
              ),
            ));
  }

  void _onTapCheck(Work work) {
    AlertUtil.showDialogAlert(
        context: context,
        message: AppStrings.Complete_task,
        title: AppStrings.Alert,
        onCancel: _onCancel,
        onConfirm: () {
          _onConfirm(work);
        },
        leftTitle: AppStrings.Confirm,
        rightTitle: AppStrings.Cancel);
  }

  void _onConfirm(Work work) {
    work.stage = 1;
    _mainScreenBloc.add(UpdateWorkEvent(work));
  }

  void _onCancel() {}

  void _onTapDelete(Work work) {
    _mainScreenBloc.add(DeleteWorkEvent(work.id));
  }
}
