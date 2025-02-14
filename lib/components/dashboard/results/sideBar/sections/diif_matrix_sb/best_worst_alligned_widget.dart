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
    Map<String, double> diffScores = displayData.diffScores;
    List<MapEntry<String, double>> sortedEntries = diffScores.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    List<MapEntry<String, double>> top3 = sortedEntries.take(3).toList();

    // Print the raw data
    print('Diff Scores Map: $diffScores');
    print('Sorted Entries: $sortedEntries');
    print('Top 3 Entries: $top3');

    String key1 = top3[0].key;
    String key2 = top3[1].key;
    String key3 = top3[2].key;

    String indicatorKey1 = key1;
    String indicatorKey2 = key2;
    String indicatorKey3 = key3;

    if (indicatorKey1 == 'crossAcc') {
      indicatorKey1 = 'crossFuncAcc';
    } else if (indicatorKey1 == 'crossComms') {
      indicatorKey1 = 'crossFuncComms';
    } else if (indicatorKey1 == 'alignedOrgStruct') {
      indicatorKey1 = 'orgAlign';
    }

    if (indicatorKey2 == 'crossAcc') {
      indicatorKey2 = 'crossFuncAcc';
    } else if (indicatorKey2 == 'crossComms') {
      indicatorKey2 = 'crossFuncComms';
    } else if (indicatorKey2 == 'alignedOrgStruct') {
      indicatorKey2 = 'orgAlign';
    }

    if (indicatorKey3 == 'crossAcc') {
      indicatorKey3 = 'crossFuncAcc';
    } else if (indicatorKey3 == 'crossComms') {
      indicatorKey3 = 'crossFuncComms';
    } else if (indicatorKey3 == 'alignedOrgStruct') {
      indicatorKey3 = 'orgAlign';
    }

// Now use indicatorKey1, indicatorKey2, and indicatorKey3

    // Print the keys
    print('Top 3 Keys: $key1, $key2, $key3');

    Map<String, double> top3Map = Map.fromEntries(top3);
    // Print the top 3 map
    print('Top 3 Map: $top3Map');

    Indicator indicator1 = Indicator.values.byName(indicatorKey1);
    Indicator indicator2 = Indicator.values.byName(indicatorKey2);
    Indicator indicator3 = Indicator.values.byName(indicatorKey3);

    // Print the enum values and their headings
    print('Indicator 1: ${indicator1}, Heading: ${indicator1.heading}');
    print('Indicator 2: ${indicator2}, Heading: ${indicator2.heading}');
    print('Indicator 3: ${indicator3}, Heading: ${indicator3.heading}');

    // Also print the actual diff values you're using
    print('Diff values from map: ${top3Map[key1]}, ${top3Map[key2]}, ${top3Map[key3]}');

    return Column(
      spacing: 16,
      children: [
        Text(heading, style: kH3PoppinsRegular),
        AreaDiffRow(heading: indicator1.heading, diff: top3Map[key1]!),
        AreaDiffRow(heading: indicator2.heading, diff: top3Map[key2]!),
        AreaDiffRow(heading: indicator3.heading, diff: top3Map[key3]!),
      ],
    );
  }
}
