import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/components/focus/focus_content/focus_area/focus_area_row.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class FocusAreasWidget extends ConsumerWidget {
  const FocusAreasWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric surveyMetric = ref.watch(metricsDataProvider).surveyMetric;
    FocusSection selectedSection = ref.watch(focusSelectedSectionProvider);

    //Get higest diff or score indicators according to specified order and which step is selected
    List<Indicator> topOppIndicators = surveyMetric.getFocusIndicators(3, selectedSection);

    return Container(
      width: 550,
      padding: EdgeInsets.only(top: 16, right: 32, left: 32, bottom: 32),
      child: Column(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Focus Areas',
            style: kH2PoppinsRegular,
          ),
          SizedBox(height: 6),
          topOppIndicators.isEmpty
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  child: Text(
                    'Welldone! All Indicators are Healthy',
                    style: kH5PoppinsLight.copyWith(color: Colors.black),
                  ),
                )
              : Column(
                  spacing: 12,
                  children: [
                    for (int i = 0; i < topOppIndicators.length; i++)
                      FocusAreaRow(
                        text: '${i + 1}. ${topOppIndicators[i].heading}',
                        diff: surveyMetric.diffScores[topOppIndicators[i]]!,
                        score: surveyMetric.companyBenchmarks[topOppIndicators[i]]!,
                        section: selectedSection,
                      ),
                  ],
                )
        ],
      ),
    );
  }
}
