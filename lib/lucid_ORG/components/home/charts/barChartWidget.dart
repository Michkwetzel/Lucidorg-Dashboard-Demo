import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({required this.scores, super.key});
  final List<double> scores;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  int? hoveredIndex;
  final chartColors = [
    const Color(0xFF9FAF82),
    const Color(0xFFB3A987),
    const Color(0xFF7FAF8C),
  ];

  BarChartGroupData _generateBarGroup(int x, double value, Color color) {
    final bool isHovered = hoveredIndex == x;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isHovered ? value + 4 : value,
          color: color,
          borderRadius: BorderRadius.circular(4),
          width: 80,
          backDrawRodData: BackgroundBarChartRodData(
            show: isHovered,
            toY: value,
            color: color.withOpacity(0.1),
          ),
        ),
      ],
      showingTooltipIndicators: isHovered ? [0] : [0],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) {
        setState(() {
          hoveredIndex = null;
        });
      },
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          minY: 0,
          groupsSpace: 12,
          barGroups: List.generate(
            widget.scores.length,
            (index) => _generateBarGroup(index, widget.scores[index], chartColors[index]),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('CEO'),
                      );
                    case 1:
                      return const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('C-Suite'),
                      );
                    case 2:
                      return const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('Team'),
                      );
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
             
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}%',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          // Add touch callback to handle hover
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.white,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 5,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${widget.scores[group.x.toInt()].toStringAsFixed(1)}%',
                  const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                );
              },
            ),
            handleBuiltInTouches: true,
            touchCallback: (event, response) {
              if (event.isInterestedForInteractions && response != null && response.spot != null) {
                setState(() {
                  hoveredIndex = response.spot!.touchedBarGroupIndex;
                });
              } else {
                setState(() {
                  hoveredIndex = null;
                });
              }
            },
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 50),
        swapAnimationCurve: Curves.easeInOut,
      ),
    );
  }
}
