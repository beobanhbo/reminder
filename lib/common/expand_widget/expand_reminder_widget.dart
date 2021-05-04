import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reminder/common/app_manager.dart';
import 'package:reminder/common/app_utils.dart';
import 'package:reminder/common/time_picker/date_picker.dart';
import 'package:reminder/common/time_picker/time_picker.dart';
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
  DateTime _dateTime, _deadline;
  bool isEnableNotification, isEnableRepeat, isEnableDeadline;
  List<DayOfWeek> _listDay = [];
  List<String> selectedDate = [];
  @override
  void initState() {
    _work = widget.work;
    isEnableNotification = _work?.enableReminder ?? false;
    isEnableRepeat = _work?.isRepeat ?? false;
    isEnableDeadline = _work?.deadline != null ? true : false;
    _listDay = _work?.week != null
        ? _work.week.listDay
        : AppManager.shared.week.listDay;
    getChosenDay(_listDay);

    _dateTime = _work?.remindAtTime;
    _deadline = _work?.deadline;

    super.initState();
  }

  @override
  void dispose() {
    selectedDate.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDeadLine(),
        _buildHeaderReminder(),
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
            children: [_buildReminderTitle(), _buildButtonNotification()],
          ),
          _buildTimeRepeat(),
        ],
      ),
    );
  }

  Widget _buildReminderTitle() {
    return GestureDetector(
        onTap: () {
          _onTimePicker();
        },
        child: _dateTime != null
            ? Text(
                '${AppStrings.RemindAt} ${AppUtils.convertFormatToDate(_dateTime)} - ${AppUtils.convertFormatToTime(_dateTime)}',
                style: isEnableNotification
                    ? AppStyles.textStyleBlue(16)
                    : AppStyles.textStyleBlackNormal(16))
            : Text(
                AppStrings.SetRemind,
                style: AppStyles.textStyleBlackNormal(16),
              ));
  }

  Widget _buildButtonNotification() {
    return GestureDetector(
      onTap: () {
        if (_dateTime == null) {
          _onTimePicker();
          isEnableNotification = true;
        } else {
          setState(() {
            isEnableNotification = !isEnableNotification;
            if (_work != null) _work.enableReminder = isEnableNotification;
          });
        }
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
          tilePadding: EdgeInsets.only(top: 0),
          initiallyExpanded: isEnableRepeat,
          trailing: _buildRepeatButton(),
          title: Row(
            children: [
              Text(
                AppStrings.Repeat,
                style: isEnableRepeat
                    ? AppStyles.textStyleBlue(16)
                    : AppStyles.textStyleBlackNormal(16),
              ),
              Container(child: _buildDateSelected()),
            ],
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
          getChosenDay(_listDay);
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
      return Text(
        AppStrings.Everyday,
        style: isEnableRepeat
            ? AppStyles.textStyleBlue(16)
            : AppStyles.textStyleBlackNormal(16),
      );
    else {
      return Row(
          children: selectedDate
              .map((e) => Text(
                    e,
                    style: isEnableRepeat
                        ? AppStyles.textStyleBlue(16)
                        : AppStyles.textStyleBlackNormal(16),
                  ))
              .toList());
    }
  }

  void _onTimePicker() {
    DateTime now;
    _dateTime != null ? now = _dateTime : now = DateTime.now();

    showTimesPicker(context,
        initDateTime: _work?.remindAtTime == null ? now : _work?.remindAtTime,
        onDateTimeChanged: (time) {
      _dateTime = time == null ? now : time;
      _work?.remindAtTime = _dateTime;
      setState(() {});
    });
  }

  void _onDatePicker() {
    DateTime now;
    _deadline != null ? now = _deadline : now = DateTime.now();

    showDatesPicker(context,
        initDateTime: _work?.deadline == null ? now : _work?.deadline,
        onDateTimeChanged: (time) {
      _deadline = time == null ? now : time;
      _work?.deadline = _deadline;
      isEnableDeadline = true;
      setState(() {});
    });
  }

  void getChosenDay(List<DayOfWeek> listDay) {
    selectedDate = AppUtils.getChoosedDayName(listDay);
  }

  Widget _buildDeadLine() {
    return GestureDetector(
        onTap: () {
          _onDatePicker();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _deadline != null
                  ? Text(
                      '${AppStrings.Deadline} ${AppUtils.convertFormatToDate(_deadline)}',
                      style: isEnableDeadline
                          ? AppStyles.textStyleBlue(16)
                          : AppStyles.textStyleBlackNormal(16))
                  : Text(
                      AppStrings.SetDeadline,
                      style: AppStyles.textStyleBlackNormal(16),
                    ),
            ),
            _buildButtonClear(),
          ],
        ));
  }

  Widget _buildButtonClear() {
    return GestureDetector(
      onTap: () {
        if (_deadline == null)
          _onDatePicker();
        else {
          setState(() {
            isEnableDeadline = !isEnableDeadline;
            if (_work != null) {
              _work.deadline = null;
              _deadline = null;
            }
          });
        }
      },
      child: Icon(
        isEnableDeadline ? Icons.close : Icons.today,
        color: isEnableDeadline ? AppColors.blue : AppColors.grey73,
      ),
    );
  }
}
