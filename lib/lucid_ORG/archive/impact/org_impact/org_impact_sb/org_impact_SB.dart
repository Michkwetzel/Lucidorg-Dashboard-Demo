// // ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/archive/impact/org_impact/org_impact_sb/components/impact_area_sb.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

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
                allIndicatorsToShow: indicatorsToShow,
              ),
            if (pillarsToShow.contains(Pilar.people))
              ImpactAreaSBWidget(
                pilar: Pilar.people,
                allIndicatorsToShow: indicatorsToShow,
              ),
            if (pillarsToShow.contains(Pilar.process))
              ImpactAreaSBWidget(
                pilar: Pilar.process,
                allIndicatorsToShow: indicatorsToShow,
              ),
            if (pillarsToShow.contains(Pilar.leadership))
              ImpactAreaSBWidget(
                pilar: Pilar.leadership,
                allIndicatorsToShow: indicatorsToShow,
              ),
          ],
        ),
      ),
    );
  }
}
