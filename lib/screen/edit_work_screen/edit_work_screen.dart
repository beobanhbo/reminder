import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reminder/common/app_manager.dart';
import 'package:reminder/common/app_utils.dart';
import 'package:reminder/common/custom_app_bar/custom_app_bar.dart';
import 'package:reminder/common/expand_widget/expand_reminder_widget.dart';
import 'package:reminder/common/task_item.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/config/app_strings.dart';
import 'package:reminder/model/work.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_bloc.dart';
import 'package:reminder/screen/main_screen/bloc/main_screen_event.dart';

class EditWorkScreen extends StatefulWidget {
  final MainScreenBloc mainScreenBloc;
  final Work work;
  EditWorkScreen(this.mainScreenBloc, {this.work});

  @override
  _EditWorkScreenState createState() => _EditWorkScreenState();
}

class _EditWorkScreenState extends State<EditWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleTextController, _phoneTextController;
  TextEditingController _taskTextController;
  bool _isEnableAddTask = false;
  String _task = '';
  List<Work> _listWork;
  Work _work;
  List<DayOfWeek> _listDayOfWeek = [];
  FocusNode _focusNode;
  FocusNode focusNode;
  MainScreenBloc _mainScreenBloc;
  String appTitle = '';
  void _initTextController() {
    _titleTextController = TextEditingController();
    _taskTextController = TextEditingController();
  }

  @override
  void initState() {
    _work = widget.work;
    _mainScreenBloc = widget.mainScreenBloc;
    _initTextController();
    _listWork = [];

    _taskTextController.addListener(_addTaskListener);
    _focusNode = FocusNode();
    appTitle = AppStrings.AddWork;
    if (_work != null) {
      onEditWork(_work);
      _listDayOfWeek = _work.week.listDay;
    } else {
      _listDayOfWeek = AppManager.shared.week?.listDay;
    }

    super.initState();
  }

  void _addTaskListener() {
    setState(() {
      _task = _taskTextController.text;
      if (_task.isNotEmpty) {
        _isEnableAddTask = true;
      } else {
        _isEnableAddTask = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appTitle,
        centerTitle: true,
        autoLeading: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: AppUtils.gradientBoxDecoration(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              decoration: AppUtils.gradientBoxDecoration(),
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 12),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              textInputAction: TextInputAction.send,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 16, 10, 0),
                                  border: UnderlineInputBorder(),
                                  labelText: AppStrings.Title,
                                  labelStyle: AppStyles.textStyleBlackBold(16)),
                              controller: _titleTextController,
                              validator: (String value) {
                                if (value.isEmpty) return AppStrings.Not_empty;
                                return null;
                              },
                              maxLines: 2,
                              minLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildReminder(_work),
                  _buildSubTask(),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _onCreateWork();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: AppColors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: AppColors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppStrings.Done,
                                style: AppStyles.textStyleWhite(16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //region _buildSubTask
  Widget _buildSubTask() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 8.0, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_buildSubTaskHeader(), _buildListTask()],
        ),
      ),
    );
  }

  Widget _buildSubTaskHeader() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.Options.toUpperCase(),
          style: AppStyles.textStyleBlackBold(16),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                focusNode: _focusNode,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 16, 10, 0),
                    suffixIcon: _isEnableAddTask
                        ? IconButton(
                            onPressed: () {
                              _taskTextController.clear();
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.blue,
                            ),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                    ),
                    hintText: AppStrings.Option,
                    labelText: AppStrings.Option),
                controller: _taskTextController,
                maxLines: 2,
                minLines: 1,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              child: TextButton.icon(
                icon: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
                onPressed: () {
                  _addTask();
                },
                label: Text(
                  AppStrings.AddTask,
                  style: AppStyles.textStyleWhite(16),
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _buildListTask() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(top: 4),
        ),
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return TaskItem(
            work: _listWork[index],
            onDelete: _onDelete,
            onClickCheckBox: onClickCheckBox,
          );
        },
        itemCount: _listWork.isEmpty ? 0 : _listWork.length,
      ),
    );
  }

  //endregion drawer
  @override
  void dispose() {
    _titleTextController.dispose();
    _taskTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addTask() {
    final int id = DateTime.now().microsecondsSinceEpoch;
    Work work = Work(title: _task, id: id.toString(), createAt: id.toString());
    _listWork.add(work);
    setState(() {
      _taskTextController.clear();
    });
  }

  _onDelete(Work work) {
    _listWork.remove(work);
    setState(() {});
  }

  _onCreateWork() {
    //   // scheduleNotification(localNotificationsPlugin, 1, "Remind", "Payload",
    //   //     DateTime.now().add(Duration(seconds: 2)));
    //   // // turnOffNotificationByID(localNotificationsPlugin, 0);
    //   // scheduleNotificationPeriodicallyShow(localNotificationsPlugin, 0, "Remind",
    //   //     "Payload", RepeatInterval.EveryMinute);
    //
    Map<String, Work> subTaskMap = {};
    List<String> listID = [];
    _listWork.forEach((item) => listID.add(item.id));
    subTaskMap =
        Map.fromEntries(_listWork.map((value) => MapEntry(value.id, value)));
    Work work = Work(
        title: _titleTextController.text,
        workChildMap: subTaskMap,
        id: _work?.id != null
            ? _work.id
            : DateTime.now().microsecondsSinceEpoch.toString(),
        createAt: DateTime.now().microsecondsSinceEpoch.toString(),
        week: Week(listDay: _listDayOfWeek));

    _work != null
        ? _mainScreenBloc.add(UpdateWorkEvent(work))
        : _mainScreenBloc.add(AddNewWorkEvent(work));

    Navigator.of(context).pop();
    //   // SMS.Message message =
    //   //     SMS.Message(to: "+84968709006", from: "+14124604148", body: "Hello");
    //   // _toDoScreenBloc.add(SendSMSEvent(message));
  }

  void onEditWork(Work work) {
    setState(() {
      appTitle = AppStrings.EditTask;
    });
    _titleTextController.text = work.title;
    _work.workChildMap.entries
        .map((item) => _listWork.add(item.value))
        .toList();
  }

  onClickCheckBox(Work work) {
    // _listWork.forEach((item) {
    //   if (item.id == work.id) {
    //     item.isSelected = !item.isSelected;
    //   }
    // });
    setState(() {});
  }

  Widget _buildReminder(Work work) {
    return ReminderWidget(
      work: _work,
    );
  }
}
