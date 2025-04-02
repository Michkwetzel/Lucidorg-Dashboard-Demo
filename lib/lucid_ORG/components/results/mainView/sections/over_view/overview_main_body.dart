import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/over_view/company_trajectory_graph.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/dataClasses/all_indicator_data.dart';
import 'package:platform_front/lucid_ORG/dataClasses/indicator_data.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class OverviewMainView extends StatelessWidget {
  const OverviewMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        Text('Company Trajectory', style: kH3PoppinsRegular),
        Stack(
          children: [
            CompanyTrajectoryGraph(),
            Positioned(
              left: 80,
              top: 50,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 60,
                  decoration: kBlackOutline,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 2,
                        children: [
                          ...List.generate(3, (index) {
                            return CircleAvatar(radius: 4, backgroundColor: Colors.green);
                          }),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Smooth Scaling',
                            style: kH6PoppinsLight,
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 2,
                        children: [
                          ...List.generate(3, (index) {
                            return CircleAvatar(radius: 4, backgroundColor: Colors.blue);
                          }),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Your Scaling',
                            style: kH6PoppinsLight,
                          )
                        ],
                      ),
                    ],
                  )),
            ),
            Positioned(
              bottom: 230,
              right: 70,
              child: SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    'High',
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.green[300], fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 138,
              right: 70,
              child: SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    'Average',
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.black45, fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 55,
              right: 70,
              child: SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    'Attention',
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.red[300], fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 170,
              right: 1,
              child: SizedBox(
                width: 70,
                child: Column(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 16,
                    ),
                    Text(
                      'Efficiency\nScore',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.black, fontWeight: FontWeight.w300, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        OverviewTextWidget(),
      ],
    );
  }
}

class OverviewTextWidget extends ConsumerWidget {
  const OverviewTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Indicator, IndicatorData> indicatorMap = AllIndicatorData.indicatorMap;
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    double companyIndex = displayData.companyBenchmarks[Indicator.companyIndex]!;
    String body = indicatorMap[Indicator.companyIndex]!.getScoreTextBody(companyIndex).replaceAll("____", '${companyIndex.toString()}%');
    String suggestions = indicatorMap[Indicator.companyIndex]!.getScoreTextSuggestion(companyIndex);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 24)),
          SizedBox(
            height: 8,
          ),
          Text(
            body,
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 15),
          ),
          SizedBox(
            height: 8,
          ),
          Text('Suggestions:', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 16)),
          SizedBox(
            height: 4,
          ),
          Text(suggestions, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 15)),
        ],
      ),
    );
  }
}
