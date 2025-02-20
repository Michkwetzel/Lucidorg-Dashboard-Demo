import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/companyInfo/styledDropdown.dart';
import 'package:platform_front/components/dashboard/impact/main_view/score_over_time/score_over_time_MV.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class DiffOverTimeMv extends ConsumerWidget {
  const DiffOverTimeMv({super.key});

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
                ScoreOverTimeRow(indicator: Indicator.orgAlign, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.growthAlign, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.collabKPIs, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.engagedCommunity, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.crossFuncComms, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.crossFuncAcc, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.alignedTech, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.collabProcesses, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.meetingEfficacy, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.purposeDriven, type: Compare.diff),
                ScoreOverTimeRow(indicator: Indicator.empoweredLeadership, type: Compare.diff),
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
