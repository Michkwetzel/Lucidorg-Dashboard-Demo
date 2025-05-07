import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/sections/change_over_time/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class DiffOverTimeSb extends ConsumerWidget {
  const DiffOverTimeSb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<Indicator, double>> topDiffImprove = ref.watch(scoreCompareProvider).topDiffImprove;
    List<Map<Indicator, double>> topDiffDecline = ref.watch(scoreCompareProvider).topDiffDecline;

    return BlurOverlay(
      blur: ref.watch(scoreCompareProvider).blur,
      child: Padding(
        padding: const EdgeInsets.all(32).copyWith(top: 40),
        child: Column(
          children: [
            Text('Diff Over Time', style: kH2PoppinsLight),
            SizedBox(height: 32),
            Column(
              children: [
                Text('Improvement', style: kH3PoppinsRegular),
                CustomDivider(
                  width: 200,
                ),
                SizedBox(height: 24),
                CompareRowSB(type: Compare.diff, change: topDiffImprove[0].entries.first.value, indicator: topDiffImprove[0].entries.first.key),
                CompareRowSB(type: Compare.diff, change: topDiffImprove[1].entries.first.value, indicator: topDiffImprove[1].entries.first.key),
                CompareRowSB(type: Compare.diff, change: topDiffImprove[2].entries.first.value, indicator: topDiffImprove[2].entries.first.key),
                SizedBox(height: 24),
                Text('Decline', style: kH3PoppinsRegular),
                CustomDivider(
                  width: 200,
                ),
                SizedBox(height: 24),
                CompareRowSB(type: Compare.diff, change: topDiffDecline[0].entries.first.value, indicator: topDiffDecline[0].entries.first.key),
                CompareRowSB(type: Compare.diff, change: topDiffDecline[1].entries.first.value, indicator: topDiffDecline[1].entries.first.key),
                CompareRowSB(type: Compare.diff, change: topDiffDecline[2].entries.first.value, indicator: topDiffDecline[2].entries.first.key),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
