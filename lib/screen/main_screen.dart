import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/common/app_utils.dart';
import 'package:reminder/config/AppColors.dart';
import 'package:reminder/config/app_assets.dart';
import 'package:reminder/config/app_font_styles.dart';
import 'package:reminder/config/app_strings.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: AppUtils.gradientBoxDecoration(),
          child: Column(
            children: [
              _buildCategory(),
              _buildListWork(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
            fit: FlexFit.tight,
            child: _buildButtonCategory(AppStrings.Daily, AppAssets.daily,
                AppUtils.boxDecorationCornerLeft())),
        Flexible(
            fit: FlexFit.tight,
            child: _buildButtonCategory(AppStrings.Plan, AppAssets.plan,
                AppUtils.boxDecorationCornerRight()))
      ],
    );
  }

  Widget _buildButtonCategory(
      String title, String path, BoxDecoration boxDecoration) {
    return GestureDetector(
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: boxDecoration,
          child: Column(
            children: [
              AppImages.asset(assetPath: path, height: 40, width: 40),
              Text(
                title,
                style: AppStyles.textStyleBlackNormal(16),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListWork() {
    return SingleChildScrollView(
      child: Container(),
    );
  }
}
