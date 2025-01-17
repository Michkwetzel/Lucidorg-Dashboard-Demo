import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class ActiveAssessmentWidget extends StatelessWidget {
  ActiveAssessmentWidget({super.key});

  // Sample data - you can replace these values
  final List<PieChartSectionData> sections = [
    PieChartSectionData(
      value: 35,
      title: '35%',
      color: Colors.blue,
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value: 40,
      title: '40%',
      color: Colors.green,
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value: 25,
      title: '25%',
      color: Colors.red,
      radius: 50,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Active Assessment', style: kH2PoppinsRegular),
          const SizedBox(height: 24),
          Text('Participation Rate:', style: kH5PoppinsLight),
          Text("73%", style: kH5PoppinsLight),
          Flexible(child: PieChartWidget(sections: sections)),
          const SizedBox(height: 24),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem('Submitted', Colors.blue),
              _buildLegendItem('Not Started', Colors.green),
              _buildLegendItem('Started', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    super.key,
    required this.sections,
  });

  final List<PieChartSectionData> sections;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        startDegreeOffset: 270, // Start from top
      ),
    );
  }
}
