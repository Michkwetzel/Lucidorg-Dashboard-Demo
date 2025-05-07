import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/company_info/styledDropdown.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/components/compare_widgets/score_over_time_row.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

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

    // Wrap with blur overlay if you want to restrict
    //   return BlurOverlay(
    //   message: "We need atleast 2 surveys to show Score Comparison",
    //   blur: ref.watch(scoreCompareProvider).blur,

    return BlurOverlay(
      message: "We need atleast 2 surveys to show Change Over Time",
      blur: ref.watch(scoreCompareProvider).blur,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 170, child: Text('Indicator', style: kH3PoppinsRegular)),
                Row(
                  spacing: 16,
                  children: [
                    SizedBox(
                        height: 50,
                        width: 125,
                        child: StyledDropdown(
                            items: surveyDisplayNames,
                            onChanged: (value) {
                              int index = surveyDisplayNames.indexOf(value);
                              ref.read(scoreCompareProvider.notifier).updateSurvey1(surveyDevNames[index]);
                            },
                            initalValue: surveyDisplayNames[0])),
                    Text('vs', style: kH5PoppinsRegular),
                    SizedBox(
                        height: 50,
                        width: 125,
                        child: StyledDropdown(
                            items: surveyDisplayNames,
                            onChanged: (value) {
                              int index = surveyDisplayNames.indexOf(value);
                              ref.read(scoreCompareProvider.notifier).updateSurvey2(surveyDevNames[index]);
                            },
                            initalValue: surveyDisplayNames[1])),
                  ],
                ),
                SizedBox(width: 125, child: Text('Change', style: kH3PoppinsRegular)),
              ],
            ),
            ChangeOverTimeActionBar(),
            CustomDivider(),
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
            CustomDivider(),
            SizedBox(
              height: 8,
            ),
            ScoreOverTimeRow(indicator: Indicator.companyIndex, type: Compare.score),
          ],
        ),
      ),
    );
  }
}

class ChangeOverTimeActionBar extends StatelessWidget {
  const ChangeOverTimeActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 32,
          children: [
            Text(
              'Change Over Time',
              style: kH3PoppinsMedium,
            ),
            ChangeOverTimeButton(section: ResultSection.scoreOverTime),
            ChangeOverTimeButton(section: ResultSection.diffOverTime)
          ],
        ),
        SizedBox(height: 6),
        CustomDivider(),
      ],
    );
  }
}

class ChangeOverTimeButton extends ConsumerWidget {
  final ResultSection section;

  const ChangeOverTimeButton({super.key, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      onPressed: () => ref.read(resultsSelectedSectionProvider.notifier).setDisplay(section),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Colors.black45, width: 0.5),
      ),
      color: ref.watch(resultsSelectedSectionProvider) == section ? Color(0xFFCFCFCF) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Text(
              section == ResultSection.diffOverTime ? "Differentiation" : "Score",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
