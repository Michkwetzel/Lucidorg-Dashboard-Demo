import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/diff_matrix/legend_item.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/diff_matrix/scores_radar_chart.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';

class DiffMatrixBody extends StatelessWidget {
  const DiffMatrixBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Differentiation Matrix',
            style: kH3PoppinsMedium,
          ),
          SizedBox(height: 6),
          GrayDivider(),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              LegendItem(label: "CEO", color: Colors.blue),
              LegendItem(label: "C-Suite", color: Colors.green),
              LegendItem(label: "Employee", color: Colors.red),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.center,
            child: ClickableRadarChart(),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
