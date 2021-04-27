import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/common/app_manager.dart';
import 'package:reminder/common/app_utils.dart';
import 'package:reminder/common/time_picker/duration_picker.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/config/app_strings.dart';
import 'package:reminder/model/work.dart';

class ReminderWidget extends StatefulWidget {
  final Work work;

  const ReminderWidget({Key key, this.work}) : super(key: key);
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget> {
  Work _work;
  DateTime _dateTime;
  bool isEnableNotification, isEnableRepeat;
  List<DayOfWeek> _listDay = [];
  List<String> selectedDate = [];
  final key = GlobalKey();
  @override
  void initState() {
    _work = widget.work;
    isEnableNotification = _work?.enableReminder ?? false;
    isEnableRepeat = _work?.isRepeat ?? false;
    _listDay = _work?.week != null
        ? _work.week.listDay
        : AppManager.shared.week.listDay;
    getChoosedDay(_listDay);

    _dateTime = _work?.remindAtTime;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHeaderReminder();
    return ExpansionTile(
      trailing: _buildButtonNotification(),
      subtitle: _buildDateSelected(),
      title: _buildReminderTitle(),
      initiallyExpanded: true,
      children: [
        _buildTimeRepeat(),
      ],
    );
  }

  Widget _buildHeaderReminder() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _onTimePicker();
                },
                child: _dateTime != null
                    ? Text(
                        '${AppStrings.RemindAt} ${AppUtils.convertFormatDateTime(_dateTime)}',
                        style: isEnableNotification
                            ? AppStyles.textStyleBlue(16)
                            : AppStyles.textStyleBlackNormal(16))
                    : Text(
                        AppStrings.Remind,
                        style: AppStyles.textStyleBlackNormal(16),
                      ),
              ),
              _buildButtonNotification()
            ],
          ),
          Container(child: _buildDateSelected()),
          ExpansionTile(
            trailing: _buildRepeatButton(),
            title: Text(
              AppStrings.Repeat,
              style: isEnableRepeat
                  ? AppStyles.textStyleBlue(16)
                  : AppStyles.textStyleBlackNormal(16),
            ),
            children: [
              _buildDaysOfWeek(_listDay),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReminderTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            onTap: () {
              _onTimePicker();
            },
            child: _dateTime != null
                ? Text(
                    '${AppStrings.RemindAt} ${AppUtils.convertFormatDateTime(_dateTime)}',
                    style: isEnableNotification
                        ? AppStyles.textStyleBlue(16)
                        : AppStyles.textStyleBlackNormal(16))
                : Text(
                    AppStrings.Remind,
                    style: AppStyles.textStyleBlackNormal(16),
                  )),
      ],
    );
  }

  Widget _buildButtonNotification() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnableNotification = !isEnableNotification;
          if (_work != null) _work.enableReminder = isEnableNotification;
        });
      },
      child: Icon(
        Icons.notifications,
        color: isEnableNotification ? AppColors.blue : AppColors.grey73,
      ),
    );
  }

  Widget _buildTimeRepeat() {
    return Column(
      children: [
        ExpansionTile(
          initiallyExpanded: isEnableRepeat,
          trailing: _buildRepeatButton(),
          title: Text(
            AppStrings.Repeat,
            style: isEnableRepeat
                ? AppStyles.textStyleBlue(16)
                : AppStyles.textStyleBlackNormal(16),
          ),
          children: [
            _buildDaysOfWeek(_listDay),
          ],
        ),
      ],
    );
  }

  Widget _buildRepeatButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnableRepeat = !isEnableRepeat;
          if (_work != null) _work.isRepeat = isEnableRepeat;
        });
      },
      child: Icon(
        Icons.check_circle_outline_outlined,
        color: isEnableRepeat ? AppColors.blue : AppColors.grey73,
      ),
    );
  }

  Widget _buildDaysOfWeek(List<DayOfWeek> listDayOfWeek) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listDayOfWeek.map((entries) => _buildDay(entries)).toList(),
      ),
    );
  }

  Widget _buildDay(DayOfWeek dayOfWeek) {
    return GestureDetector(
      onTap: () {
        setState(() {
          dayOfWeek.isSelected = !dayOfWeek.isSelected;
          getChoosedDay(_listDay);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: dayOfWeek.isSelected ? AppColors.blue : AppColors.grey73,
        ),
        height: 42,
        width: 42,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(2),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            dayOfWeek.dayName,
            style: AppStyles.textStyleWhite(12),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelected() {
    final unselectedDate = _listDay.firstWhere(
        (element) => element.isSelected == false,
        orElse: () => null);
    if (unselectedDate == null)
      return Text(AppStrings.Everyday);
    else {
      return Row(children: selectedDate.map((e) => Text(e)).toList());
    }
  }

  void _onTimePicker() {
    DateTime now;
    _dateTime != null ? now = _dateTime : now = DateTime.now();

    showDurationPicker(context,
        initDateTime: _work?.remindAtTime == null ? now : _work?.remindAtTime,
        onDateTimeChanged: (time) {
      _dateTime = time == null ? now : time;
      _work?.remindAtTime = _dateTime;
      setState(() {});
    });
  }

  void getChoosedDay(List<DayOfWeek> listDay) {
    selectedDate = AppUtils.getChoosedDayName(listDay);
  }
}
