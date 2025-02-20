import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/companyInfo/styledDropdown.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/components/global/score_boxes/diff_box.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class ScoreOverTimeMV extends ConsumerWidget {
  const ScoreOverTimeMV({
    super.key,
  });

  String getYearAndQuarter(String timestamp, Map<String, int> quarterCount) {
    String datePart = timestamp.split('T')[0];
    List<String> parts = datePart.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int quarter = ((month - 1) ~/ 3) + 1;

    // Create the base key
    String baseKey = '$year Q$quarter';

    // If this quarter hasn't been seen before, initialize its count
    quarterCount.putIfAbsent(baseKey, () => 0);
    // Increment the count for this quarter
    quarterCount[baseKey] = quarterCount[baseKey]! + 1;

    // If this is not the first survey in this quarter, add the decimal suffix
    if (quarterCount[baseKey]! > 1) {
      return '$baseKey.${quarterCount[baseKey]! - 1}';
    }

    return baseKey;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, SurveyMetric> surveyNames = MetricsData().allSurveyMetrics;
    bool showBlur = false;

    if (surveyNames.isEmpty || surveyNames.length < 2) {
      showBlur = true;
      surveyNames = {
        '2025-02-20T13-08-49': SurveyMetric.loadDefaultValues(),
        '2025-06-20T13-08-49': SurveyMetric.loadDefaultValues(),
      };
    }

    // Keep track of how many surveys we've seen for each quarter
    Map<String, int> quarterCount = {};
    Map<String, SurveyMetric> formattedSurveyNames = {};

    // Sort the original timestamps to ensure consistent ordering
    List<String> sortedTimestamps = surveyNames.keys.toList()..sort();

    // Create formatted keys while keeping track of duplicates
    for (String timestamp in sortedTimestamps) {
      String formattedKey = getYearAndQuarter(timestamp, quarterCount);
      formattedSurveyNames[formattedKey] = surveyNames[timestamp]!;
    }

    List<String> sortedKeys = formattedSurveyNames.keys.toList()..sort();
    String firstKey = sortedKeys[0];
    String secondKey = sortedKeys.length > 1 ? sortedKeys[1] : firstKey;

    return BlurOverlay(
      message: "We need atleast 2 surveys to show Score/Diff Comparison",
      blur: showBlur,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 170, child: Text('Impact Chart', style: kH3PoppinsRegular)),
                Row(
                  spacing: 16,
                  children: [
                    SizedBox(
                        height: 40,
                        width: 125,
                        child: StyledDropdown(
                            items: sortedKeys,
                            onChanged: (value) {
                              ref.read(scoreCompareProvider.notifier).updateSurvey1(formattedSurveyNames[value]!);
                            },
                            initalValue: firstKey)),
                    Text('vs', style: kH5PoppinsRegular),
                    SizedBox(
                        height: 40,
                        width: 125,
                        child: StyledDropdown(
                            items: sortedKeys,
                            onChanged: (value) {
                              ref.read(scoreCompareProvider.notifier).updateSurvey2(formattedSurveyNames[value]!);
                            },
                            initalValue: secondKey)),
                  ],
                ),
                SizedBox(width: 125, child: Text('Difference', style: kH3PoppinsRegular)),
              ],
            ),
            GrayDivider(),
            SizedBox(
              height: 8,
            ),
            Column(
              spacing: 16,
              children: [
                ScoreOverTimeRow(indicator: Indicator.orgAlign, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.growthAlign, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.collabKPIs, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.engagedCommunity, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.crossFuncComms, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.crossFuncAcc, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.alignedTech, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.collabProcesses, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.meetingEfficacy, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.purposeDriven, type: Compare.score),
                ScoreOverTimeRow(indicator: Indicator.empoweredLeadership, type: Compare.score),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            GrayDivider(),
            SizedBox(
              height: 8,
            ),
            OverallScoreOverTimeRow(
              category: 'Overall',
              score1: 43.5,
              score2: 50.6,
            )
          ],
        ),
      ),
    );
  }
}

class ScoreOverTimeRow extends ConsumerWidget {
  final Indicator indicator;
  final Compare type; //If score or diff

  const ScoreOverTimeRow({
    super.key,
    required this.indicator,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric survey1;
    SurveyMetric survey2;
    double value1;
    double value2;
    double change;
    Color arrowColor;
    IconData icon;

    bool canShow = ref.watch(scoreCompareProvider).canShow;

    if (canShow) {
      survey1 = ref.watch(scoreCompareProvider).survey1;
      survey2 = ref.watch(scoreCompareProvider).survey2;
    } else {
      survey1 = SurveyMetric.loadDefaultValues();
      survey2 = SurveyMetric.loadDefaultValues();
    }

    if (type == Compare.score) {
      value1 = survey1.companyBenchmarks[indicator]!;
      value2 = survey2.companyBenchmarks[indicator]!;
      if (value1 == value2) {
        arrowColor = Colors.grey;
        icon = Icons.arrow_upward;
      } else if (value1 > value2) {
        arrowColor = Colors.red;
        icon = Icons.arrow_downward;
      } else {
        arrowColor = Colors.green;
        icon = Icons.arrow_upward;
      }
    } else {
      value1 = survey1.diffScores[indicator]!;
      value2 = survey2.diffScores[indicator]!;
      if (value1 == value2) {
        arrowColor = Colors.grey;
        icon = Icons.arrow_upward;
      } else if (value1 > value2) {
        arrowColor = Colors.green;
        icon = Icons.arrow_upward;
      } else {
        arrowColor = Colors.red;
        icon = Icons.arrow_downward;
      }
    }

    change = (value1 - value2).abs();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170,
          child: Text(indicator.heading, style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
        ),
        SizedBox(
          width: 200.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              type == Compare.score
                  ? ScoreBox(score: value1, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300)
                  : DiffBox(diff: value1, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300),
              type == Compare.score
                  ? ScoreBox(score: value2, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300)
                  : DiffBox(diff: value2, width: 65, height: 40, textSize: 15, fontWeight: FontWeight.w300),
            ],
          ),
        ),
        SizedBox(
          width: 125,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: arrowColor,
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                width: 60,
                height: 40,
                decoration: kGrayBox,
                child: Center(child: Text('${change.toStringAsFixed(1)}%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class OverallScoreOverTimeRow extends StatelessWidget {
  final String category;
  final double score1;
  final double score2;

  const OverallScoreOverTimeRow({
    super.key,
    required this.category,
    required this.score1,
    required this.score2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170,
          child: Text(category, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
        ),
        SizedBox(
          width: 200.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 65,
                height: 38,
                decoration: kGrayBox,
                child: Center(child: Text('$score1%', style: TextStyle(color: Color(0xFF5478ED), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
              Container(
                width: 65,
                height: 38,
                decoration: kGrayBox,
                child: Center(child: Text('$score2%', style: TextStyle(color: Color(0xFF5478ED), fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 125,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 40,
                decoration: kGrayBox,
                child: Center(child: Text('${(score1 - score2).abs().toStringAsFixed(1)}%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
              ),
            ],
          ),
        )
      ],
    );
  }
}
