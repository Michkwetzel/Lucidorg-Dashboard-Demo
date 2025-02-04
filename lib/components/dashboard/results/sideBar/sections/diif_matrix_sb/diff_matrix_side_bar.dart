import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/diif_matrix_sb/best_worst_alligned_widget.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/components/global/grayDivider.dart';
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
          Text(
            'Differentiation',
            style: kH2PoppinsLight,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(style: kH6PoppinsLight, textAlign: TextAlign.center,
            'Differentation is a measure of how well the departments in your organization align. a Lower differentiation score is better'),
          SizedBox(height: 16),
          GrayDivider(
            width: 200,
          ),
          SizedBox(height: 16),
          BestWorstAllignedWidget(
            type: Alligned.best,
          ),
          SizedBox(height: 32),
          GrayDivider(
            width: 200,
          ),
          SizedBox(height: 32),
          BestWorstAllignedWidget(type: Alligned.worst),
        ],
      ),
    );
  }
}
