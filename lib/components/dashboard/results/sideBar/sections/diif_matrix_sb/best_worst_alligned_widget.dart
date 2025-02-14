import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/diif_matrix_sb/area_diff_row.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class HighestDiffWidget extends ConsumerWidget {
  const HighestDiffWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String heading = 'Highest Differentiation';
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    // Get 3 highest Diff scores.
    Map<Indicator, double> diffScores = displayData.diffScores;
    List<MapEntry<Indicator, double>> sortedEntries = diffScores.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    List<MapEntry<Indicator, double>> top3 = sortedEntries.take(3).toList();

    // Print the raw data
    print('Diff Scores Map: $diffScores');
    print('Sorted Entries: $sortedEntries');
    print('Top 3 Entries: $top3');

    Indicator indicator1 = top3[0].key;
    Indicator indicator2 = top3[1].key;
    Indicator indicator3 = top3[2].key;

    return Column(
      spacing: 16,
      children: [
        Text(heading, style: kH3PoppinsRegular),
        AreaDiffRow(heading: indicator1.heading, diff: top3[0].value),
        AreaDiffRow(heading: indicator2.heading, diff: top3[1].value),
        AreaDiffRow(heading: indicator3.heading, diff: top3[2].value),
      ],
    );
  }
}
