import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        if (widget.work.stage != 1)
          IconSlideAction(
            onTap: widget.onCheck,
            iconWidget: AppImages.asset(
                assetPath: AppAssets.ic_check, color: AppColors.white),
            color: AppColors.green,
          ),
        IconSlideAction(
          onTap: widget.onEdit,
          iconWidget: AppImages.asset(
              assetPath: AppAssets.ic_edit, color: AppColors.white),
          color: AppColors.orange,
        ),
        IconSlideAction(
          onTap: widget.onDelete,
          iconWidget: AppImages.asset(
              assetPath: AppAssets.ic_delete_group, color: AppColors.white),
          color: AppColors.red,
        ),
      ],
      child: GestureDetector(
        onTap: () {},
        child: _buildWorkItem(),
      ),
    );
  }

  Widget _buildWorkItem() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.work.stage == 0
              ? Icon(
                  Icons.check_circle_outline_outlined,
                  color: AppColors.lightTextGrey,
                )
              : Icon(
                  Icons.check_circle_outline_outlined,
                  color: AppColors.green,
                ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.work.title,
            style: widget.work.stage == 0
                ? AppStyles.textStyleBlackNormal(16)
                : AppStyles.textStyleGreenNormal(16),
          )
        ],
      ),
    );
  }
}
