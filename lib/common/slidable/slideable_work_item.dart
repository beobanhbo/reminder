import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideWorkItem extends StatefulWidget {
  final Key slidableKey;
  final SlidableController slidableController;

  SlideWorkItem(this.slidableKey, this.slidableController);

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
      secondaryActions: [IconSlideAction(iconWidget: ,)],
      child: child,

    );
  }
}
