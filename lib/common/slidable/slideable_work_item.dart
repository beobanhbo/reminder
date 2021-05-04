import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reminder/common/app_utils.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_assets.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/model/work.dart';

class SlideWorkItem extends StatefulWidget {
  final Key slidableKey;
  final SlidableController slidableController;
  final Work work;
  final Function onDelete, onCheck, onEdit;
  SlideWorkItem(
      {this.slidableKey,
      this.slidableController,
      this.work,
      this.onDelete,
      this.onCheck,
      this.onEdit});

  @override
  _SlideWorkItemState createState() => _SlideWorkItemState();
}

class _SlideWorkItemState extends State<SlideWorkItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: widget.slidableController,
      actionPane: SlidableDrawerActionPane(),
      key: widget.slidableKey,
      secondaryActions: [
        IconSlideAction(
          onTap: widget.onCheck,
          iconWidget: AppImages.asset(
              assetPath: widget.work.stage == 0
                  ? AppAssets.ic_check
                  : AppAssets.ic_undo_alt_blue,
              color: AppColors.white),
          color: AppColors.green,
        ),
        IconSlideAction(
          onTap: widget.onDelete,
          iconWidget: AppImages.asset(
              assetPath: AppAssets.ic_delete_group, color: AppColors.white),
          color: AppColors.red,
        ),
      ],
      child: GestureDetector(
        onTap: () {
          widget.onEdit();
        },
        child: _buildWorkItem(),
      ),
    );
  }

  Widget _buildWorkItem() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.work.stage == 0
                  ? Icon(
                      Icons.radio_button_off,
                      color: AppColors.lightTextGrey,
                      size: 20,
                    )
                  : Icon(
                      Icons.check_circle_outline_outlined,
                      color: AppColors.green,
                      size: 20,
                    ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  widget.work.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: AppStyles.textStyleBlackNormal(16),
                ),
              ),
            ],
          ),
          widget.work?.deadline != null
              ? Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.calendar_today_sharp,
                        size: 14,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        AppUtils.formatTime(
                            widget.work?.deadline.toString(), "yMMMMd"),
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.textStyleBlackNormal(14),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
