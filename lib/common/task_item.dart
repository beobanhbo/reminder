import 'package:flutter/material.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/config/app_strings.dart';
import 'package:reminder/model/work.dart';

class TaskItem extends StatefulWidget {
  final Work work;
  final Function(Work) onDelete, onClickCheckBox;
  const TaskItem({Key key, this.work, this.onDelete, this.onClickCheckBox})
      : super(key: key);
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
        background: slideRightBackground(),
        direction: DismissDirection.endToStart,
        onDismissed: _onDelete,
        child: InkWell(
          onTap: () {
            onClickCheckBox(widget.work);
          },
          child: Container(
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.grey73),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
              height: 40,
              child: Row(
                children: <Widget>[
                  // Container(
                  //     margin: EdgeInsets.only(left: 6, right: 6),
                  //     child: Icon(widget.work.isSelected
                  //         ? Icons.check_box
                  //         : Icons.check_box_outline_blank)),
                  Text(
                    widget.work?.title ?? "Unknown",
                    style: AppStyles.textStyleBlackNormal(16),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _onDelete(DismissDirection direction) {
    if (widget.onDelete != null) widget.onDelete(widget.work);
  }

  void onClickCheckBox(Work work) {
    if (widget.onClickCheckBox != null) widget.onClickCheckBox(widget.work);
  }

  Widget slideRightBackground() {
    return Container(
      color: AppColors.red,
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              AppStrings.Remove,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
