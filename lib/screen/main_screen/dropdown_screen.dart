import 'package:flutter/material.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_assets.dart';

class DropDownScreen extends StatefulWidget {
  final List<Recommend> list;
  final Function(Recommend) onTap;
  const DropDownScreen({Key key, this.list, this.onTap}) : super(key: key);
  @override
  _DropDownScreenState createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
        ),
        padding: EdgeInsets.all(25),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => _buildItem(widget.list[index]),
          separatorBuilder: (context, index) => Divider(
            height: 40,
          ),
          itemCount: widget.list.length,
        ),
      ),
    );
  }

  Widget _buildItem(Recommend recommend) {
    return GestureDetector(
      onTap: () {
        widget.onTap(recommend);
        Navigator.of(context).pop();
      },
      child: Row(
        children: [
          Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(right: 25),
              constraints: BoxConstraints(maxWidth: 40, maxHeight: 40),
              child: AppImages.asset(assetPath: recommend.iconPath)),
          Text(recommend.title)
        ],
      ),
    );
  }
}

class Recommend {
  final String title, iconPath;

  Recommend({this.title, this.iconPath});
}
