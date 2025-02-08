import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class CompanyTrajectoryGraph extends StatelessWidget {
  const CompanyTrajectoryGraph({super.key});

  final double efficiencyScore = 55.7;

  // Helper function to generate points for both sigmoid curves
  List<List<FlSpot>> _generateDoubleSigmoidPoints() {
    List<FlSpot> firstCurve = [];
    List<FlSpot> secondCurve = [];
    List<FlSpot> thirdCurve = [];

    // Parameters for the first sigmoid
    double L1 = 40; // Maximum value for first curve
    double k1 = 3; // Steepness
    double x01 = 2.5; // Midpoint

    // Parameters for the second sigmoid
    double L2 = 40; // Additional height for second curve
    double k2 = 3.2; // Steepness
    double x02 = 5; // Midpoint (shifted right)

    // Generate points for both curves
    for (double x = 1; x <= 6; x += 0.1) {
      // First sigmoid
      double y1 = L1 / (1 + exp(-k1 * (x - x01)));
      firstCurve.add(FlSpot(x, y1));

      // Second sigmoid (shifted up and right)
      double y2 = y1 + (L2 / (1 + exp(-k2 * (x - x02)))) + 5;
      secondCurve.add(FlSpot(x, y2));
    }

    for (double x = 1; x <= 4; x += 0.1) {
      // First sigmoid
      double y1 = 30 / (1 + exp(-k1 * (x - x01))) + 5;
      thirdCurve.add(FlSpot(x, y1));
    }

    return [firstCurve, secondCurve, thirdCurve];
  }

  // Helper function to get Y value at X=4
  double _getYValueAtX4(List<FlSpot> spots) {
    return spots.firstWhere((spot) => spot.x == 4.0, orElse: () => spots.reduce((a, b) => (b.x - 4.0).abs() < (a.x - 4.0).abs() ? b : a)).y;
  }

  @override
  Widget build(BuildContext context) {
    final curves = _generateDoubleSigmoidPoints();

    // Get Y values at X=4
    final blueValueAtX4 = _getYValueAtX4(curves[2]);
    final redValueAtX4 = _getYValueAtX4(curves[1]);

    return Row(
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Row(
            spacing: 4,
            children: [
              Text('Growth', style: kH6PoppinsLight),
              Icon(
                Icons.arrow_forward,
                size: 16,
                weight: 1,
              )
            ],
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              height: 370,
              width: 650,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    enabled: false,
                    getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((index) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: Colors.transparent,
                          ),
                          FlDotData(
                            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                              radius: 4,
                              color: Colors.blue,
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            ),
                          ),
                        );
                      }).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.white,
                      tooltipRoundedRadius: 8,
                      tooltipMargin: 0,
                      tooltipPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      tooltipBorder: BorderSide(color: Colors.black12),
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          return LineTooltipItem(
                            '${efficiencyScore.toString()}%',
                            TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          );
                        }).toList();
                      },
                      fitInsideVertically: true,
                    ),
                  ),
                  showingTooltipIndicators: [
                    ShowingTooltipIndicators([LineBarSpot(LineChartBarData(), 0, FlSpot(4.3, (efficiencyScore - 26)))])
                  ],
                  gridData: FlGridData(
                    show: false,
                    drawVerticalLine: true,
                    horizontalInterval: 20,
                    verticalInterval: 1,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value == 1) {
                            return Text('');
                          }
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        interval: 20,
                        getTitlesWidget: (value, meta) {
                          return Text('${value.toInt()}%');
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      left: BorderSide(color: Colors.black12),
                      bottom: BorderSide(color: Colors.black12),
                    ),
                  ),
                  minX: 1,
                  maxX: 6,
                  minY: 0,
                  maxY: 100,
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      // HorizontalLine(
                      //   y: blueValueAtX4,
                      //   color: Colors.blue.withOpacity(0.2),
                      //   strokeWidth: 1,
                      //   dashArray: [5, 5],
                      //   label: HorizontalLineLabel(
                      //     show: true,
                      //     alignment: Alignment.topRight,
                      //     padding: EdgeInsets.only(right: 5),
                      //     style: TextStyle(color: Colors.blue),
                      //     labelResolver: (line) => 'Efficiency Score:  ${(blueValueAtX4 + 20).toStringAsFixed(1)}%',
                      //   ),
                      // ),
                      HorizontalLine(
                        y: 46.3,
                        color: Colors.black12,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                        label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 5),
                          style: TextStyle(color: Colors.black45),
                          labelResolver: (line) => '70%',
                        ),
                      ),
                      HorizontalLine(
                        y: 20,
                        color: Colors.black12,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                        label: HorizontalLineLabel(
                          show: true,
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 5),
                          style: TextStyle(color: Colors.black45),
                          labelResolver: (line) => '45%',
                        ),
                      ),
                    ],
                    // verticalLines: [
                    //   VerticalLine(
                    //     x: 4,
                    //     color: Colors.blue.withOpacity(0.3),
                    //     strokeWidth: 1,
                    //     dashArray: [5, 5],
                    //   ),
                    // ],
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: curves[2],
                      isCurved: true,
                      barWidth: 0,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.blue,
                          );
                        },
                      ),
                      color: Colors.blue,
                    ),
                    LineChartBarData(
                      spots: curves[1],
                      isCurved: true,
                      barWidth: 0,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Color(0xFFB9D08F),
                          );
                        },
                      ),
                      color: Colors.red.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Align(
                alignment: Alignment.center,
                child: Row(
                  spacing: 4,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Text('Years'),
                    Icon(Icons.arrow_forward, size: 16, weight: 1)
                  ],
                )),
          ],
        ),
      ],
    );
  }
}
