import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/dataClasses/all_indicator_data.dart';
import 'package:platform_front/dataClasses/indicator_data.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class FoundationsBody extends StatelessWidget {
  const FoundationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 335,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 335,
                        height: 170,
                        child: FoundationsTopTextWidget(indicator: Indicator.operations),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          spacing: 16,
                          children: [
                            Text(
                              'Allignment',
                              style: kH4PoppinsRegular,
                            ),
                            FoundationsRow(indicator: Indicator.growthAlign),
                            FoundationsRow(indicator: Indicator.collabKPIs),
                            FoundationsRow(indicator: Indicator.orgAlign),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              'Process',
                              style: kH4PoppinsRegular,
                            ),
                            FoundationsRow(indicator: Indicator.alignedTech),
                            FoundationsRow(indicator: Indicator.collabProcesses),
                            FoundationsRow(indicator: Indicator.meetingEfficacy),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 335,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 335,
                        height: 170,
                        child: FoundationsTopTextWidget(
                          indicator: Indicator.workforce,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: Column(
                          spacing: 16,
                          children: [
                            Text(
                              'People',
                              style: kH4PoppinsRegular,
                            ),
                            FoundationsRow(indicator: Indicator.engagedCommunity),
                            FoundationsRow(indicator: Indicator.crossFuncComms),
                            FoundationsRow(indicator: Indicator.crossFuncAcc),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              'Leadership',
                              style: kH4PoppinsRegular,
                            ),
                            FoundationsRow(indicator: Indicator.empoweredLeadership),
                            FoundationsRow(indicator: Indicator.purposeDriven),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Center(
            child: Container(
          width: 1,
          height: 700,
          color: Colors.grey,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              GrayDivider(),
            ],
          ),
        )
      ],
    );
  }
}

class FoundationsTopTextWidget extends ConsumerWidget {
  final Indicator indicator;
  const FoundationsTopTextWidget({
    super.key,
    required this.indicator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    double score = displayData.companyBenchmarks[indicator]!;
    Map<Indicator, IndicatorData> allIndicatorData = AllIndicatorData.indicatorMap;

    String scoreTextBody = allIndicatorData[indicator]!.getScoreTextBody(score).replaceAll("___", '${score.toString()}%');

    String scoreTextHeading = allIndicatorData[indicator]!.getScoreTextHeading(score);

    return Column(
      children: [
        Text(indicator.heading, style: kH2PoppinsMedium),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            spacing: 16,
            children: [
              ScoreBox(score: score, width: 75, height: 55, textSize: 18, fontWeight: FontWeight.w300),
              Text(
                scoreTextHeading,
                textAlign: TextAlign.center,
                style: kH7PoppinsRegular,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FoundationsRow extends ConsumerWidget {
  final Indicator indicator;
  const FoundationsRow({super.key, required this.indicator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;
    double score = displayData.companyBenchmarks[indicator]!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 125,
          child: Text(
            indicator.heading,
            style: kH6PoppinsLight,
          ),
        ),
        ScoreBox(score: score, width: 65, height: 42, textSize: 14, fontWeight: FontWeight.w300),
      ],
    );
  }
}
