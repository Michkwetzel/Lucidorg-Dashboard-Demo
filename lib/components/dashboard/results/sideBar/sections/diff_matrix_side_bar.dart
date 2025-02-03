import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/components/dashboard/results/sideBar/components/high_level_scores_widget.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class DiffMatrixSideBar extends StatelessWidget {
  const DiffMatrixSideBar({
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
          Text('Overall\nDifferentiation', style: kH2PoppinsLight, textAlign: TextAlign.center,),
          SizedBox(height: 8),
          DiffTriangleRedWidget(value: 38, size: Diffsize.H2),
          SizedBox(height: 45),
          BestWorstAllignedWidget(heading: 'Best Aligned'),
          SizedBox(height: 32),
          BestWorstAllignedWidget(heading: 'Worst Aligned'),
        ],
      ),
    );
  }
}
