import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/indicators/department_scores_widget.dart';
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
            'Overall Department Benchmarks',
            style: kH2PoppinsLight,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          GrayDivider(
            width: 200,
          ),
          SizedBox(height: 32),
          OverallDepertmentBenchmarkWidget(),
          SizedBox(height: 32),
          GrayDivider(
            width: 200,
          ),
          SizedBox(height: 16),
          HighestDiffWidget(),
        ],
      ),
    );
  }
}
