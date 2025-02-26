import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/indicators/department_scores_widget.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/diif_matrix_sb/best_worst_alligned_widget.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

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
          TopTextWidgetDiffMatrixsb(),
          SizedBox(height: 16),
          GrayDivider(
            width: 200,
          ),
          SizedBox(height: 32),
          DepartmentScoresDiffMatrix(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

class TopTextWidgetDiffMatrixsb extends ConsumerWidget {
  const TopTextWidgetDiffMatrixsb({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = ref.watch(selectedDiffMatrixProvider);

    return Text(
      selectedIndicator.heading,
      style: kH2PoppinsLight,
      textAlign: TextAlign.center,
    );
  }
}
