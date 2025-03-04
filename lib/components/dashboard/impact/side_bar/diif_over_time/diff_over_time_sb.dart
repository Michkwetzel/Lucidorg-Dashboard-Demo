import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class DiffOverTimeSb extends ConsumerWidget {
  const DiffOverTimeSb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<Indicator, double>> topDiffImprove = ref.watch(scoreCompareProvider).topDiffImprove;
    List<Map<Indicator, double>> topDiffDecline = ref.watch(scoreCompareProvider).topDiffDecline;

    return Padding(
      padding: const EdgeInsets.all(32).copyWith(top: 40),
      child: Column(
        spacing: 16,
        children: [
          BlurOverlay(
            blur: ref.watch(scoreCompareProvider).blur,
            child: Column(
              children: [
                Text('Scores Over Time', style: kH2PoppinsLight),
                SizedBox(height: 16),
                Text('Improvement', style: kH3PoppinsRegular),
                GrayDivider(
                  width: 200,
                ),
                CompareRowSB(type: Compare.diff, change: topDiffImprove[0].entries.first.value, indicator: topDiffImprove[0].entries.first.key),
                CompareRowSB(type: Compare.diff, change: topDiffImprove[1].entries.first.value, indicator: topDiffImprove[1].entries.first.key),
                CompareRowSB(type: Compare.diff, change: topDiffImprove[2].entries.first.value, indicator: topDiffImprove[2].entries.first.key),
                SizedBox(height: 16),
                Text('Decline', style: kH3PoppinsRegular),
                GrayDivider(
                  width: 200,
                ),
                CompareRowSB(type: Compare.diff, change: topDiffDecline[0].entries.first.value, indicator: topDiffDecline[0].entries.first.key),
                CompareRowSB(type: Compare.diff, change: topDiffDecline[1].entries.first.value, indicator: topDiffDecline[1].entries.first.key),
                CompareRowSB(type: Compare.diff, change: topDiffDecline[2].entries.first.value, indicator: topDiffDecline[2].entries.first.key),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
