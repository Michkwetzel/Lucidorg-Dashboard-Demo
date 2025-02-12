// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/overview_sb/high_level_scores_widget.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class OverViewSBResults extends StatelessWidget {
  const OverViewSBResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Overall Score", style: kH2PoppinsLight),
          SizedBox(height: 8),
          Text('55.7%', style: kH2TotalScoreLight),
          SizedBox(height: 60),
          Text('Overall Differentiation', style: kH3PoppinsLight),
          SizedBox(height: 8),
          DiffTriangleRedWidget(value: 38, size: Diffsize.H2),
          SizedBox(height: 60),
          HighLevelScoresWidget(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
