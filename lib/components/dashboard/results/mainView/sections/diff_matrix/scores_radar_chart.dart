import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class ScoresRadarChart extends ConsumerStatefulWidget {
  ScoresRadarChart({super.key});

  @override
  ConsumerState<ScoresRadarChart> createState() => _ScoresRadarChartState();
}

class _ScoresRadarChartState extends ConsumerState<ScoresRadarChart> {
  String? hoveredValue; // Store the hovered value

  @override
  Widget build(BuildContext context) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    List<Indicator> indicatorList = justIndicators();

    final List<String> categories = [];
    final List<double> ceoScores = [];
    final List<double> csuiteScores = [];
    final List<double> staffScores = [];

    for (Indicator indicator in indicatorList) {
      categories.add(indicator.heading);
      ceoScores.add(displayData.ceoBenchmarks[indicator]!);
      csuiteScores.add(displayData.cSuiteBenchmarks[indicator]!);
      staffScores.add(displayData.employeeBenchmarks[indicator]!);
    }

    return SizedBox(
      width: 700,
      height: 700,
      child: RadarChart(
        RadarChartData(
          radarTouchData: RadarTouchData(enabled: true),
          dataSets: [
            // CEO Data
            RadarDataSet(
              fillColor: Colors.blue.withOpacity(0.2),
              borderColor: Colors.blue,
              entryRadius: 2,
              dataEntries: ceoScores.map((score) => RadarEntry(value: score)).toList(),
            ),
            // CSUITE Data
            RadarDataSet(
              fillColor: Colors.green.withOpacity(0.2),
              borderColor: Colors.green,
              entryRadius: 2,
              dataEntries: csuiteScores.map((score) => RadarEntry(value: score)).toList(),
            ),
            // STAFF Data
            RadarDataSet(
              fillColor: Colors.red.withOpacity(0.2),
              borderColor: Colors.red,
              entryRadius: 2,
              dataEntries: staffScores.map((score) => RadarEntry(value: score)).toList(),
            ),
          ],
          radarShape: RadarShape.circle,
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: true),
          radarBorderData: BorderSide(color: Colors.grey),
          titlePositionPercentageOffset: 0.2,
          titleTextStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 13),
          getTitle: (index, angle) {
            return RadarChartTitle(text: categories[index], angle: 0);
          },
          tickCount: 2,
          ticksTextStyle: const TextStyle(fontSize: 10, color: Colors.grey),
          tickBorderData: BorderSide(color: Colors.grey),
          gridBorderData: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
