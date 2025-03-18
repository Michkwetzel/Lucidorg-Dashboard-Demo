import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/dashboard/companyInfo/styledDropdown.dart';
import 'package:platform_front/components/dashboard/impact/compare_widgets/overall_score_over_time_row.dart';
import 'package:platform_front/components/dashboard/impact/compare_widgets/score_over_time_row.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class ScoreOverTimeMV extends ConsumerWidget {
  const ScoreOverTimeMV({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, SurveyMetric> surveyMetrics = ref.watch(scoreCompareProvider).allComparableSurveys;
    List<String> surveyDevNames = [];
    List<String> surveyDisplayNames = [];

    for (var value in surveyMetrics.entries) {
      surveyDevNames.add(value.key);
      surveyDisplayNames.add(value.value.surveyStartDate);
    }

    print('$surveyDevNames');
    print('$surveyDisplayNames');

    return BlurOverlay(
      message: "We need atleast 2 surveys to show Score Comparison",
      blur: ref.watch(scoreCompareProvider).blur,
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
                        height: 50,
                        width: 110,
                        child: StyledDropdown(
                            items: surveyDisplayNames,
                            onChanged: (value) {
                              int index = surveyDisplayNames.indexOf(value);
                              ref.read(scoreCompareProvider.notifier).updateSurvey2(surveyDevNames[index]);
                            },
                            initalValue: surveyDisplayNames[0])),
                    Text('vs', style: kH5PoppinsRegular),
                    SizedBox(
                        height: 50,
                        width: 110,
                        child: StyledDropdown(
                            items: surveyDisplayNames,
                            onChanged: (value) {
                              int index = surveyDisplayNames.indexOf(value);
                              ref.read(scoreCompareProvider.notifier).updateSurvey2(surveyDevNames[index]);
                            },
                            initalValue: surveyDisplayNames[1])),
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
              type: Compare.score,
              indicator: Indicator.companyIndex,
            )
          ],
        ),
      ),
    );
  }
}
