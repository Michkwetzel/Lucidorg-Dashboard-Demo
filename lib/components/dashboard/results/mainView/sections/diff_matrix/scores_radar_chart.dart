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
    Department selectedDepartment = ref.watch(selectedDepartmentDiffMatrixNotiferProvider);

    List<Indicator> indicatorList = justIndicators();

    final List<String> categories = [];
    final List<double> ceoScores = [];
    final List<double> csuiteScores = [];
    final List<double> staffScores = [];

    for (Indicator indicator in indicatorList) {
      categories.add(indicator.radarChartHeading);
      ceoScores.add(displayData.ceoBenchmarks[indicator]!);
      csuiteScores.add(displayData.cSuiteBenchmarks[indicator]!);
      staffScores.add(displayData.employeeBenchmarks[indicator]!);
    }

    return RadarChart(
      RadarChartData(
        radarTouchData: RadarTouchData(enabled: true),
        dataSets: [
          // CEO Data
          RadarDataSet(
            fillColor: selectedDepartment == Department.ceo ? Colors.blue.withOpacity(0.1) : Colors.transparent,
            borderColor: Colors.blue,
            entryRadius: 2,
            dataEntries: ceoScores.map((score) => RadarEntry(value: score)).toList(),
          ),
          // CSUITE Data
          RadarDataSet(
            fillColor: selectedDepartment == Department.cSuite ? Colors.green.withOpacity(0.1) : Colors.transparent,
            borderColor: Colors.green,
            entryRadius: 2,
            dataEntries: csuiteScores.map((score) => RadarEntry(value: score)).toList(),
          ),
          // STAFF Data
          RadarDataSet(
            fillColor: selectedDepartment == Department.staff ? Colors.red.withOpacity(0.1) : Colors.transparent,
            borderColor: Colors.red,
            entryRadius: 2,
            dataEntries: staffScores.map((score) => RadarEntry(value: score)).toList(),
          ),
        ],
        radarShape: RadarShape.circle,
        radarBackgroundColor: Colors.transparent,
        borderData: FlBorderData(show: true),
        radarBorderData: BorderSide(color: Colors.grey),
        titlePositionPercentageOffset: 0.12,
        titleTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 13),
        getTitle: (index, angle) {
          return RadarChartTitle(text: categories[index], angle: 0);
        },
        tickCount: 5,
        ticksTextStyle: const TextStyle(fontSize: 10, color: Colors.grey),
        tickBorderData: BorderSide(color: Colors.grey),
        gridBorderData: BorderSide(color: Colors.grey),
      ),
    );
  }
}

class ClickableRadarChart extends StatelessWidget {
  const ClickableRadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 900,
      height: 700,
      child: Stack(
        children: [
          ScoresRadarChart(),
          Positioned(left: 372, top: 10, child: ClickableTitle(60, 30, Indicator.companyIndex)),
          Positioned(left: 508, top: 40, child: ClickableTitle(120, 45, Indicator.orgAlign)),
          Positioned(left: 648, top: 160, child: ClickableTitle(82, 45, Indicator.growthAlign)),
          Positioned(left: 685, top: 330, child: ClickableTitle(100, 45, Indicator.collabKPIs)),
          Positioned(left: 640, top: 495, child: ClickableTitle(100, 45, Indicator.engagedCommunity)),
          Positioned(left: 500, top: 615, child: ClickableTitle(140, 45, Indicator.crossFuncComms)),
          Positioned(left: 335, top: 665, child: ClickableTitle(135, 45, Indicator.crossFuncAcc)),
          Positioned(left: 190, top: 620, child: ClickableTitle(90, 42, Indicator.alignedTech)),
          Positioned(left: 70, top: 500, child: ClickableTitle(90, 42, Indicator.collabProcesses)),
          Positioned(left: 35, top: 330, child: ClickableTitle(75, 42, Indicator.meetingEfficacy)),
          Positioned(left: 80, top: 165, child: ClickableTitle(70, 42, Indicator.purposeDriven)),
          Positioned(left: 190, top: 42, child: ClickableTitle(90, 42, Indicator.empoweredLeadership)),
        ],
      ),
    );
  }
}

class ClickableTitle extends ConsumerWidget {
  final double height;
  final double width;
  final Indicator indicator;
  const ClickableTitle(this.width, this.height, this.indicator, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleTitleTap(Indicator index) {
      ref.read(selectedDiffMatrixProvider.notifier).changeSBDisplay(index);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => handleTitleTap(indicator),
      onExit: (_) => handleTitleTap(indicator),
      child: GestureDetector(
        onTap: () => handleTitleTap(indicator),
        // Add these to handle touch interactions better
        onTapDown: (_) => handleTitleTap(indicator),
        onTapUp: (_) => handleTitleTap(indicator),
        onTapCancel: () => handleTitleTap(indicator),
        child: Container(
          width: width,
          height: height,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
