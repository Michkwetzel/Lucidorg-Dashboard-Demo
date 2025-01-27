import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    required this.values,
  });

  final List<double> values;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;
  final List<String> labels = ['Submitted', 'Started', 'Not Started'];
  final List<Color> colors = [const Color(0xFFA6A6A6), const Color(0xFFD9D9D9), const Color(0xFFA2B088)];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sections: showingSections(),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          startDegreeOffset: 270,
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.values.length, (i) {
      final isTouched = i == touchedIndex;
      final radius = isTouched ? 55.0 : 50.0;

      return PieChartSectionData(
        value: widget.values[i],
        title: '${widget.values[i].toString()}%',
        color: colors[i],
        radius: radius,
      );
    });
  }
}
