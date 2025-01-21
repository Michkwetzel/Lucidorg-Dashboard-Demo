import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/home/charts/barChartWidget.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class EfficiencyScoresWidget extends StatelessWidget {
  EfficiencyScoresWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: kboxShadowNormal,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Efficiency Scores', style: kH2PoppinsRegular),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: 360,
                child: BarChartWidget(scores: [61, 84, 46]),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Total Score', style: kH2PoppinsLight),
                SizedBox(height: 8),
                Text('55%', style: kH1TotalScoreRegular),
                SizedBox(height: 35),
                Text('Differentiation', style: kH3PoppinsLight),
                SizedBox(height: 8),
                DiffTriangleRedWidget(
                  size: Diffsize.H1,
                  value: '~38%',
                )
              ])
            ],
          )
        ],
      ),
    );
  }
}
