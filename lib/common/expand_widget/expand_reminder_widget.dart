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
  Duration duration;
  bool isEnableNotification;
  List<DayOfWeek> _listDay = [];
  List<String> selectedDate = [];
  @override
  void initState() {
    _work = widget.work;
    isEnableNotification = _work?.enableReminder ?? false;
    _listDay = _work?.week != null
        ? _work.week.listDay
        : AppManager.shared.week.listDay;
    duration = _work?.remindAtDate ?? Duration(hours: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: _buildButtonNotification(),
      subtitle: _buildDateSelected(),
      title: _buildReminderTitle(),
      children: [
        _buildTimeRepeat(),
      ],
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
            child: duration != null
                ? Text(
                    '${AppStrings.RemindAt} ${duration.toString().replaceFirst(":00.000000", "")}',
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
//          _work.enableReminder = !_work?.enableReminder ?? false;
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
          trailing: Icon(Icons.check_circle_outline_outlined),
          title: Text(AppStrings.Repeat),
          children: [
            _buildDaysOfWeek(_listDay),
          ],
        ),
      ],
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

          selectedDate = AppUtils.getChoosedDayName(_listDay);
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
    showDurationPicker(context, initDuration: duration,
        onDurationChanged: (duration) {
      if (duration == null)
        this.duration = this.duration ?? Duration(hours: 1, minutes: 0);
      else
        this.duration = duration;
      widget.work?.remindAtDate =
          this.duration.toString().replaceFirst(":00.000000", "");
      setState(() {});
    });
  }
}