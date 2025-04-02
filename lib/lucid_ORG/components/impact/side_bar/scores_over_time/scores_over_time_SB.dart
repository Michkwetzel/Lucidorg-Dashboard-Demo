import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/impact/compare_widgets/change_score_diff_box.dart';
import 'package:platform_front/global_components/blurOverlay.dart';
import 'package:platform_front/global_components/grayDivider.dart';

import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class ScoresOverTimeSB extends ConsumerWidget {
  const ScoresOverTimeSB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<Indicator, double>> topScoreImprove = ref.watch(scoreCompareProvider).topScoreImprove;
    List<Map<Indicator, double>> topScoreDecline = ref.watch(scoreCompareProvider).topScoreDecline;

    return Padding(
      padding: const EdgeInsets.all(32).copyWith(top: 40),
      child: Column(
        children: [
          Text('Scores Over Time', style: kH2PoppinsLight),
          SizedBox(height: 32),
          BlurOverlay(
            blur: ref.watch(scoreCompareProvider).blur,
            child: Column(
              children: [
                Text('Improvement', style: kH3PoppinsRegular),
                GrayDivider(width: 200),
                SizedBox(height: 24),
                CompareRowSB(type: Compare.score, change: topScoreImprove[0].entries.first.value, indicator: topScoreImprove[0].entries.first.key),
                CompareRowSB(type: Compare.score, change: topScoreImprove[1].entries.first.value, indicator: topScoreImprove[1].entries.first.key),
                CompareRowSB(type: Compare.score, change: topScoreImprove[2].entries.first.value, indicator: topScoreImprove[2].entries.first.key),
                SizedBox(height: 24),
                Text('Decline', style: kH3PoppinsRegular),
                GrayDivider(width: 200),
                SizedBox(height: 24),
                CompareRowSB(type: Compare.score, change: topScoreDecline[0].entries.first.value, indicator: topScoreDecline[0].entries.first.key),
                CompareRowSB(type: Compare.score, change: topScoreDecline[1].entries.first.value, indicator: topScoreDecline[1].entries.first.key),
                CompareRowSB(type: Compare.score, change: topScoreDecline[2].entries.first.value, indicator: topScoreDecline[2].entries.first.key),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompareRowSB extends StatelessWidget {
  final Indicator indicator;
  final double change;
  final Compare type;

  const CompareRowSB({super.key, required this.type, required this.change, required this.indicator});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            indicator.heading,
            style: kH5PoppinsLight,
          ),
        ),
        ChangeScoreDiffBox(
          scoreChange: change,
          type: type,
        )
      ],
    );
  }
}
