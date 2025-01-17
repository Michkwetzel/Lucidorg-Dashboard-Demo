import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/home/charts/barChartWidget.dart';
import 'package:platform_front/components/dashboard/home/charts/pieChartWidget.dart';
import 'package:platform_front/config/constants.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Home",
                style: kH1TextStyle,
              ),
              Text(
                'Assessment: Q1 2025',
                style: kH5PoppinsLight,
              )
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(children: [
              EfficiencyScoresWidget(),
              SizedBox(
                width: 16,
              ),
              ActiveAssessmentWidget()
            ]),
          )
        ],
      ),
    );
  }
}

class EfficiencyScoresWidget extends StatelessWidget {
  EfficiencyScoresWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 8)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
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
                width: 400,
                child: BarChartWidget(scores: [61, 84, 46]),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Total Score', style: kH2PoppinsLight),
                SizedBox(height: 8),
                Text('55%', style: kH1TotalScore),
                SizedBox(height: 35),
                Text('Total Score', style: kH3PoppinsLight),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.arrow_drop_up, size: 50, color: Colors.red), // or any color you prefer
                    Text('~38%', style: kH1Diff),
                  ],
                )
              ])
            ],
          )
        ],
      ),
    );
  }
}
