// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/impact/impact_body.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/components/impact_area_sb.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class OrgImpactSB extends ConsumerWidget {
  const OrgImpactSB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    List<Indicator> indicatorsToShow = displayData.returnImpactChartIndicators();
    List<Pilar> pillarsToShow = [];
    for (Indicator indicator in indicatorsToShow) {
      pillarsToShow.add(indicator.pilar);
    }

    return Padding(
      padding: const EdgeInsets.all(25).copyWith(top: 40),
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Text('Impact Areas', style: kH2PoppinsLight),
            if (pillarsToShow.contains(Pilar.alignment))
              ImpactAreaSBWidget(
                pilar: Pilar.alignment,
                AllIndicatorsToShow: indicatorsToShow,
              ),
            if (pillarsToShow.contains(Pilar.people))
              ImpactAreaSBWidget(
                pilar: Pilar.people,
                AllIndicatorsToShow: indicatorsToShow,
              ),
            if (pillarsToShow.contains(Pilar.process))
              ImpactAreaSBWidget(
                pilar: Pilar.process,
                AllIndicatorsToShow: indicatorsToShow,
              ),
            if (pillarsToShow.contains(Pilar.leadership))
              ImpactAreaSBWidget(
                pilar: Pilar.leadership,
                AllIndicatorsToShow: indicatorsToShow,
              ),
          ],
        ),
      ),
    );
  }
}
