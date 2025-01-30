import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScoresRadarChart extends StatelessWidget {
  final List<double> ceoScores = [8.5, 7.2, 9.0, 8.8, 7.5, 8.2, 9.1, 8.4, 7.8, 8.9, 8.6];
  final List<double> csuiteScores = [7.8, 6.9, 8.5, 8.2, 7.1, 7.8, 8.6, 7.9, 7.4, 8.3, 8.0];
  final List<double> staffScores = [6.5, 6.0, 7.2, 7.0, 6.2, 6.8, 7.4, 6.8, 6.3, 7.1, 6.9];

  final List<String> categories = [
    'Leadership',
    'Innovation',
    'Strategy',
    'Execution',
    'Communication',
    'Teamwork',
    'Decision Making',
    'Problem Solving',
    'Customer Focus',
    'Results Orientation',
    'Change Management',
  ];

  ScoresRadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 620,
      height: 620,
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
          tickCount: 5,
          ticksTextStyle: const TextStyle(fontSize: 10, color: Colors.grey),
          tickBorderData: BorderSide(color: Colors.grey),
          gridBorderData: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
