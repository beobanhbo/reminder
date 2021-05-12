import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reminder/common/ActionButton.dart';
import 'package:reminder/common/alert_dialog/alert_util.dart';
import 'package:reminder/common/app_utils.dart';
import 'package:reminder/common/slidable/slideable_work_item.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_assets.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/config/app_strings.dart';
import 'package:reminder/model/main_args.dart';
import 'package:reminder/model/work.dart';
import 'package:reminder/screen/edit_work_screen/edit_work_screen.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_event.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_state.dart';
import 'package:reminder/screen/main_screen/dropdown_screen.dart';

import '../../config/AppColors.dart';
import 'bloc/main_screen_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainScreenBloc _mainScreenBloc;
  List<Work> _listWork = [];
  bool hide = false;
  String path;
  final SlidableController slidableController = SlidableController();
  List<mod> list = [
    mod("Cafe1", 0, 1000),
    mod("Cafe2", 0, 2000),
    mod("Cafe3", 0, 3000),
    mod("Cafe4", 0, 4000),
    mod("Cafe5", 0, 5000),
    mod("Cafe6", 0, 6000),
    mod("Cafe7", 0, 7000),
    mod("Cafe8", 0, 8000),
    mod("Cafe9", 0, 9000),
    mod("Cafe10", 0, 10000),
  ];
  List<Recommend> listRe = [
    Recommend(title: "CHon cach hien thi", iconPath: AppAssets.icSuccessfully),
    Recommend(title: "Grid", iconPath: AppAssets.plan),
    Recommend(title: "List", iconPath: AppAssets.icError),
    Recommend(title: "More", iconPath: AppAssets.ic_edit),
    Recommend(title: "More 2", iconPath: AppAssets.ic_delete_group),
  ];
  Map<String, mod> mapCount = {};
  @override
  void initState() {
    _mainScreenBloc = BlocProvider.of<MainScreenBloc>(context);
    _mainScreenBloc.add(FetchDataEvent());
    path = AppAssets.ic_check;
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
            hide = !hide;
            setState(() {});
//            _onOpenEditScreen(
//                mainArgs: MainArgs(screenType: ScreenType.ADD_WORK));
          },
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: AppUtils.gradientBoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          color: AppColors.white,
                          child: _buildDropDown(_onTapDown),
                        ),
                      ),
                      Container(
                        height: 50,
                        color: AppColors.white,
                        child: _buildDropDown(_onTapDown),
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    initialValue: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        color: AppColors.red,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppImages.asset(assetPath: path),
                          Icon(Icons.arrow_downward)
                        ],
                      ),
                    ),
                    offset: const Offset(0, kToolbarHeight),
                    onSelected: (int value) {
                      path = AppAssets.ic_edit;
                      setState(() {});
                    },
                    itemBuilder: (context) {
                      return List.generate(5, (index) {
                        return PopupMenuItem(
                          value: index,
                          child: Text('button no $index'),
                        );
                      });
                    },
                  ),
                  Container(
                    color: AppColors.green,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return Divider(
                          indent: 10,
                        );
                      },
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ActionButton(
                        onTap: () {
                          _onTap(list[index]);
                        },
                        title: "${list[index].title} ${list[index].number}",
                        iconPath: AppAssets.ic_check,
                        backgroundColor: AppColors.red,
                        titleColor: AppColors.white,
                      ),
                      itemCount: list.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapDown() {
    showDialog(
        context: context,
        builder: (context) => DropDownScreen(
              list: listRe,
              onTap: _onTapDrop,
            ));
  }

  _onTapDrop(Recommend recommend) {
    setState(() {
      path = recommend.iconPath;
    });
  }

  Widget _buildDropDown(Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          color: AppColors.red,
        ),
        child: Row(
          children: [
            AppImages.asset(assetPath: path),
            SizedBox(width: 10,),
            Icon(Icons.arrow_downward)
          ],
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: AppColors.grey73),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
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
                        _onOpenEditScreen(
                            mainArgs: MainArgs(
                                work: _listWork[index],
                                screenType: ScreenType.EDIT_WORK));
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
              _onOpenEditScreen(
                  mainArgs: MainArgs(screenType: ScreenType.ADD_WORK));
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

  void _onOpenEditScreen({MainArgs mainArgs}) {
    showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
              value: _mainScreenBloc,
              child: EditWorkScreen(
                _mainScreenBloc,
                mainArgs: mainArgs,
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
    _mainScreenBloc.add(DeleteWorkEvent(work));
  }

  void _onTap(mod mods) {
    int index = list.indexWhere((element) => element.title == mods.title);
    list[index].number = mods.number + 1;
    setState(() {});
  }

  void countAddToCart(mod modss) {
    if (mapCount[modss.title] == null) {
      mapCount['${modss.title}'] = modss;
    } else {
      mapCount['${modss.title}'].number = mapCount['${modss.title}'].number + 1;
    }
  }
}

class mod {
  String title;
  int number;
  int price;

  mod(this.title, this.number, this.price);
}
