import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/topOppertunitiesWidget/top_oppertunities_row.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class TopOppWidget extends ConsumerWidget {
  const TopOppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric surveyMetric = ref.watch(metricsDataProvider).surveyMetric;

    List<Indicator> topOppIndicators = surveyMetric.getHighestDiffIndicators(2);
    Indicator highestConcernIndicator = surveyMetric.getLowestScoreIndicator();

    double score1 = surveyMetric.companyBenchmarks[topOppIndicators[0]]!;
    double score2 = surveyMetric.companyBenchmarks[topOppIndicators[1]]!;

    double diff1 = surveyMetric.diffScores[topOppIndicators[0]]!;
    double diff2 = surveyMetric.diffScores[topOppIndicators[1]]!;

    return Container(
      width: 706,
      padding: EdgeInsets.only(top: 16, right: 32, left: 32, bottom: 32),
      decoration: kboxShadowNormal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Opportunities',
            style: kH2PoppinsRegular,
          ),
          TopOppertunitiesRow(text: topOppIndicators[0].heading, diff: diff1, score: score1),
          TopOppertunitiesRow(text: topOppIndicators[1].heading, diff: diff2, score: score2),
          TopOppertunitiesRow(text: highestConcernIndicator.heading, diff: surveyMetric.diffScores[highestConcernIndicator]!, score: surveyMetric.companyBenchmarks[highestConcernIndicator]!),
        ],
      ),
    );
  }
}
