import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScoresRadarChart extends StatelessWidget {
  final List<double> ceoScores = [45.7, 91.3, 33.8, 88.2, 80, 71.4, 89.6, 95.1, 28.4, 76.5, 20, 82.9];
  final List<double> csuiteScores = [60, 80, 11, 85.1, 39.8, 65.4, 87.2, 92.6, 80, 72.7, 68.9, 78.4];
  final List<double> staffScores = [60, 86.6, 80, 82.2, 20, 68.5, 84.9, 55, 78, 69.8, 63, 44];

  final List<String> categories = [
    'Efficiency Score',
    'Org Alignment',
    'Growth Alignment',
    'Collaborative KPI',
    'Engaged Community',
    'X-Func Communication',
    'X-Funct Accountability',
    'Aligned Tech',
    'Collaborative Processes',
    'Meeting Efficacy',
    'Purpose Led Everything',
    'Empowered Leadership'
  ];

  ScoresRadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      height: 700,
      child: RadarChart(
        RadarChartData(
          radarTouchData: RadarTouchData(enabled: true),
          dataSets: [
            // CEO Data
            RadarDataSet(
              fillColor: Colors.white10,
              borderColor: Colors.blue,
              entryRadius: 2,
              dataEntries: ceoScores.map((score) => RadarEntry(value: score)).toList(),
            ),
            // CSUITE Data
            RadarDataSet(
              fillColor: Colors.white10,
              borderColor: Colors.green,
              entryRadius: 2,
              dataEntries: csuiteScores.map((score) => RadarEntry(value: score)).toList(),
            ),
            // STAFF Data
            RadarDataSet(
              fillColor: Colors.white10,
              borderColor: Colors.red,
              entryRadius: 2,
              dataEntries: staffScores.map((score) => RadarEntry(value: score)).toList(),
            ),
          ],
          radarShape: RadarShape.circle,
          radarBackgroundColor: Colors.transparent,
          borderData: FlBorderData(show: true),
          radarBorderData: BorderSide(color: Colors.grey),
          //titlePositionPercentageOffset: 0.2,
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
