// Create a class for individual survey metrics
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class SurveyMetric {
  final Map<Indicator, double> ceoBenchmarks;
  final Map<Indicator, double> cSuiteBenchmarks;
  final Map<Indicator, double> employeeBenchmarks;
  final Map<Indicator, double> companyBenchmarks;
  final Map<Indicator, double> diffScores;
  final double nCeoFinished;
  final double nCSuiteFinished;
  final double nEmployeeFinished;
  final double nSurveys;
  final double nStarted;
  final double nSubmitted;
  final String surveyDevName;
  final String surveyStartDate;
  final bool unableToCalculate; //Not all departments filled in survey

  SurveyMetric({
    required this.companyBenchmarks,
    required this.ceoBenchmarks,
    required this.cSuiteBenchmarks,
    required this.employeeBenchmarks,
    required this.diffScores,
    required this.nCeoFinished,
    required this.nCSuiteFinished,
    required this.nEmployeeFinished,
    required this.nSurveys,
    required this.nStarted,
    required this.nSubmitted,
    required this.surveyDevName,
    required this.surveyStartDate,
    required this.unableToCalculate,
  });

  factory SurveyMetric.empty() {
    return SurveyMetric(
      companyBenchmarks: {},
      ceoBenchmarks: {},
      cSuiteBenchmarks: {},
      employeeBenchmarks: {},
      diffScores: {},
      nCeoFinished: 0,
      nCSuiteFinished: 0,
      nEmployeeFinished: 0,
      nSurveys: 0,
      nStarted: 0,
      nSubmitted: 0,
      surveyDevName: '',
      surveyStartDate: '',
      unableToCalculate: true,
    );
  }

  factory SurveyMetric.loadDefaultValues({double nCeoFinished = 1, double nCSuiteFinished = 4, double nEmployeeFinished = 12, double nSurveys = 20, double nStarted = 18}) {
    Map<Indicator, double> ceoBenchmarks = {
      Indicator.align: 58.3,
      Indicator.meetingEfficacy: 100.0,
      Indicator.leadership: 52.9,
      Indicator.companyIndex: 58.0,
      Indicator.workforce: 55.6,
      Indicator.orgAlign: 83.3,
      Indicator.alignedTech: 100.0,
      Indicator.growthAlign: 66.7,
      Indicator.collabKPIs: 50.0,
      Indicator.crossFuncAcc: 66.7,
      Indicator.crossFuncComms: 16.7,
      Indicator.people: 57.4,
      Indicator.engagedCommunity: 66.7,
      Indicator.collabProcesses: 50.0,
      Indicator.process: 73.0,
      Indicator.purposeDriven: 83.3,
      Indicator.operations: 67.1,
      Indicator.empoweredLeadership: 33.3
    };

    Map<Indicator, double> cSuiteBenchmarks = {
      Indicator.purposeDriven: 75.0,
      Indicator.meetingEfficacy: 91.7,
      Indicator.companyIndex: 61.2,
      Indicator.leadership: 61.9,
      Indicator.engagedCommunity: 83.3,
      Indicator.collabKPIs: 50.0,
      Indicator.process: 69.8,
      Indicator.people: 58.7,
      Indicator.collabProcesses: 50.0,
      Indicator.empoweredLeadership: 58.3,
      Indicator.alignedTech: 91.7,
      Indicator.crossFuncAcc: 58.3,
      Indicator.crossFuncComms: 16.7,
      Indicator.growthAlign: 83.3,
      Indicator.orgAlign: 58.3,
      Indicator.align: 59.0,
      Indicator.operations: 65.4,
      Indicator.workforce: 60.0
    };

    Map<Indicator, double> employeeBenchmarks = {
      Indicator.companyIndex: 53.9,
      Indicator.meetingEfficacy: 50.0,
      Indicator.growthAlign: 55.6,
      Indicator.collabProcesses: 55.6,
      Indicator.engagedCommunity: 55.6,
      Indicator.operations: 55.1,
      Indicator.crossFuncAcc: 55.6,
      Indicator.empoweredLeadership: 55.6,
      Indicator.align: 58.1,
      Indicator.workforce: 53.9,
      Indicator.process: 53.1,
      Indicator.crossFuncComms: 50.0,
      Indicator.alignedTech: 55.6,
      Indicator.purposeDriven: 55.6,
      Indicator.orgAlign: 77.8,
      Indicator.leadership: 56.2,
      Indicator.people: 52.3,
      Indicator.collabKPIs: 55.6
    };

    Map<Indicator, double> companyBenchmarks = {
      Indicator.purposeDriven: 61.8,
      Indicator.growthAlign: 62.8,
      Indicator.orgAlign: 73.5,
      Indicator.collabProcesses: 53.9,
      Indicator.collabKPIs: 53.9,
      Indicator.alignedTech: 66.7,
      Indicator.crossFuncComms: 40.2,
      Indicator.empoweredLeadership: 54.9,
      Indicator.engagedCommunity: 62.8,
      Indicator.meetingEfficacy: 62.7,
      Indicator.crossFuncAcc: 56.9,
      Indicator.companyIndex: 55.9,
      Indicator.workforce: 55.4,
      Indicator.operations: 58.3,
      Indicator.align: 58.3,
      Indicator.process: 58.2,
      Indicator.leadership: 57.3,
      Indicator.people: 54.1
    };

    Map<Indicator, double> differenceScores = {
      Indicator.purposeDriven: 27.8,
      Indicator.growthAlign: 27.8,
      Indicator.orgAlign: 25.0,
      Indicator.collabProcesses: 5.6,
      Indicator.collabKPIs: 5.6,
      Indicator.alignedTech: 44.4,
      Indicator.crossFuncComms: 33.3,
      Indicator.empoweredLeadership: 25.0,
      Indicator.engagedCommunity: 27.8,
      Indicator.meetingEfficacy: 50.0,
      Indicator.crossFuncAcc: 11.1,
      Indicator.companyIndex: 7.3,
      Indicator.workforce: 6.1,
      Indicator.operations: 12.0,
      Indicator.align: 0.8,
      Indicator.process: 19.9,
      Indicator.leadership: 9.0,
      Indicator.people: 6.4
    };

    String surveyName = 'Default';

    return SurveyMetric(
      ceoBenchmarks: ceoBenchmarks,
      cSuiteBenchmarks: cSuiteBenchmarks,
      employeeBenchmarks: employeeBenchmarks,
      companyBenchmarks: companyBenchmarks,
      diffScores: differenceScores,
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nSurveys: nSurveys,
      nStarted: nStarted,
      nSubmitted: nCeoFinished + nEmployeeFinished + nCSuiteFinished,
      surveyDevName: surveyName,
      surveyStartDate: '',
      unableToCalculate: false,
    );
  }

  factory SurveyMetric.loadBlurredData(
      {String surveyName = 'Default',
      double nCeoFinished = 1,
      double nCSuiteFinished = 4,
      double nEmployeeFinished = 12,
      double nSurveys = 20,
      double nStarted = 18,
      required String surveyStartDate}) {
    Map<Indicator, double> ceoBenchmarks = {
      Indicator.align: 65.7,
      Indicator.meetingEfficacy: 91.2,
      Indicator.leadership: 58.4,
      Indicator.companyIndex: 2.3,
      Indicator.workforce: 62.1,
      Indicator.orgAlign: 88.5,
      Indicator.alignedTech: 95.0,
      Indicator.growthAlign: 70.3,
      Indicator.collabKPIs: 55.8,
      Indicator.crossFuncAcc: 71.4,
      Indicator.crossFuncComms: 25.3,
      Indicator.people: 60.2,
      Indicator.engagedCommunity: 72.9,
      Indicator.collabProcesses: 58.6,
      Indicator.process: 77.8,
      Indicator.purposeDriven: 86.2,
      Indicator.operations: 69.7,
      Indicator.empoweredLeadership: 40.8
    };

    Map<Indicator, double> cSuiteBenchmarks = {
      Indicator.purposeDriven: 78.9,
      Indicator.meetingEfficacy: 87.3,
      Indicator.companyIndex: 2.5,
      Indicator.leadership: 65.2,
      Indicator.engagedCommunity: 80.6,
      Indicator.collabKPIs: 60.2,
      Indicator.process: 74.4,
      Indicator.people: 63.8,
      Indicator.collabProcesses: 61.5,
      Indicator.empoweredLeadership: 59.7,
      Indicator.alignedTech: 85.9,
      Indicator.crossFuncAcc: 65.7,
      Indicator.crossFuncComms: 35.2,
      Indicator.growthAlign: 77.8,
      Indicator.orgAlign: 63.5,
      Indicator.align: 64.3,
      Indicator.operations: 68.2,
      Indicator.workforce: 66.7
    };

    Map<Indicator, double> employeeBenchmarks = {
      Indicator.companyIndex: 3.1,
      Indicator.meetingEfficacy: 53.6,
      Indicator.growthAlign: 58.9,
      Indicator.collabProcesses: 59.4,
      Indicator.engagedCommunity: 59.2,
      Indicator.operations: 59.8,
      Indicator.crossFuncAcc: 58.7,
      Indicator.empoweredLeadership: 61.3,
      Indicator.align: 62.8,
      Indicator.workforce: 57.4,
      Indicator.process: 57.1,
      Indicator.crossFuncComms: 42.1,
      Indicator.alignedTech: 59.3,
      Indicator.purposeDriven: 60.5,
      Indicator.orgAlign: 75.1,
      Indicator.leadership: 59.6,
      Indicator.people: 56.9,
      Indicator.collabKPIs: 58.7
    };

    Map<Indicator, double> companyBenchmarks = {
      Indicator.purposeDriven: 68.5,
      Indicator.growthAlign: 65.7,
      Indicator.orgAlign: 75.7,
      Indicator.collabProcesses: 59.8,
      Indicator.collabKPIs: 58.2,
      Indicator.alignedTech: 72.7,
      Indicator.crossFuncComms: 36.9,
      Indicator.empoweredLeadership: 57.3,
      Indicator.engagedCommunity: 66.9,
      Indicator.meetingEfficacy: 69.2,
      Indicator.crossFuncAcc: 63.6,
      Indicator.companyIndex: 2.7,
      Indicator.workforce: 61.4,
      Indicator.operations: 63.9,
      Indicator.align: 63.9,
      Indicator.process: 65.1,
      Indicator.leadership: 60.7,
      Indicator.people: 59.2
    };

// Calculate difference scores (maximum absolute difference between departments)
    Map<Indicator, double> differenceScores = {
      Indicator.purposeDriven: 25.7, // |86.2 - 60.5| = 25.7
      Indicator.growthAlign: 18.9, // |77.8 - 58.9| = 18.9
      Indicator.orgAlign: 25.0, // |88.5 - 63.5| = 25.0
      Indicator.collabProcesses: 2.9, // |61.5 - 58.6| = 2.9
      Indicator.collabKPIs: 4.4, // |60.2 - 55.8| = 4.4
      Indicator.alignedTech: 35.7, // |95.0 - 59.3| = 35.7
      Indicator.crossFuncComms: 16.9, // |42.1 - 25.3| = 16.8
      Indicator.empoweredLeadership: 20.5, // |61.3 - 40.8| = 20.5
      Indicator.engagedCommunity: 21.4, // |80.6 - 59.2| = 21.4
      Indicator.meetingEfficacy: 37.6, // |91.2 - 53.6| = 37.6
      Indicator.crossFuncAcc: 12.7, // |71.4 - 58.7| = 12.7
      Indicator.companyIndex: 0.8, // |3.1 - 2.3| = 0.8
      Indicator.workforce: 9.3, // |66.7 - 57.4| = 9.3
      Indicator.operations: 9.9, // |69.7 - 59.8| = 9.9
      Indicator.align: 2.9, // |65.7 - 62.8| = 2.9
      Indicator.process: 20.7, // |77.8 - 57.1| = 20.7
      Indicator.leadership: 6.8, // |65.2 - 58.4| = 6.8
      Indicator.people: 6.9 // |63.8 - 56.9| = 6.9
    };

    return SurveyMetric(
      ceoBenchmarks: ceoBenchmarks,
      cSuiteBenchmarks: cSuiteBenchmarks,
      employeeBenchmarks: employeeBenchmarks,
      companyBenchmarks: companyBenchmarks,
      diffScores: differenceScores,
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nSurveys: nSurveys,
      nStarted: nStarted,
      nSubmitted: nCeoFinished + nEmployeeFinished + nCSuiteFinished,
      surveyDevName: surveyName,
      surveyStartDate: surveyStartDate,
      unableToCalculate: false,
    );
  }

  factory SurveyMetric.fromStringFields({
    required Map<String, dynamic> ceoBenchmarks,
    required Map<String, dynamic> cSuiteBenchmarks,
    required Map<String, dynamic> employeeBenchmarks,
    required double nCeoFinished,
    required double nCSuiteFinished,
    required double nEmployeeFinished,
    required double nSurveys,
    required double nStarted,
    required String surveyName,
  }) {
    // Get String maps and convert to Enum Indicators.
    Map<Indicator, double> convertToBenchmarkMap(Map<String, dynamic> rawMap) {
      Map<Indicator, double> resultMap = {};

      for (Indicator indicator in Indicator.values) {
        String enumString = indicator.toString();
        List<String> parts = enumString.split('.');
        String key = parts.last;
        dynamic rawValue = rawMap[key];
        if (rawValue != null) {
          double value = rawValue.toDouble();
          if (value != 0.0) {
            resultMap[indicator] = value;
          }
        }
      }

      return resultMap;
    }

    Map<Indicator, double> ceoBenchmarksMap = convertToBenchmarkMap(ceoBenchmarks);
    Map<Indicator, double> cSuiteBenchmarksMap = convertToBenchmarkMap(cSuiteBenchmarks);
    Map<Indicator, double> employeeBenchmarksMap = convertToBenchmarkMap(employeeBenchmarks);
    Map<Indicator, double> companyBenchmarksMap = {};
    Map<Indicator, double> diffScoresMap = {};

    //Calculate combined company benchmark
    if (employeeBenchmarksMap.isNotEmpty && cSuiteBenchmarksMap.isNotEmpty && ceoBenchmarksMap.isNotEmpty) {
      for (final key in ceoBenchmarksMap.keys) {
        companyBenchmarksMap[key] = (((ceoBenchmarksMap[key]! * nCeoFinished) + (cSuiteBenchmarksMap[key]! * nCSuiteFinished) + (employeeBenchmarksMap[key]! * nEmployeeFinished)) /
            (nCeoFinished + nCSuiteFinished + nEmployeeFinished));
      }
      for (final key in ceoBenchmarksMap.keys) {
        double value1 = (ceoBenchmarksMap[key]! - cSuiteBenchmarksMap[key]!).abs();
        double value2 = (ceoBenchmarksMap[key]! - employeeBenchmarksMap[key]!).abs();
        double value3 = (cSuiteBenchmarksMap[key]! - employeeBenchmarksMap[key]!).abs();
        diffScoresMap[key] = max(value1, max(value2, value3));
      }
    }

    // Convert to percent. from 0.111 to 11.1
    Map<Indicator, double> convertBenchmarks(Map<Indicator, dynamic>? benchmarks) {
      return benchmarks?.map((key, value) {
            final numValue = value as num?;
            return MapEntry(key, numValue != null ? (((numValue.toDouble() * 1000).roundToDouble()) / 10) : 0.0);
          }) ??
          {};
    }

    List<String> processSurveyDate(String dateString) {
      try {
        // Split into date and time parts
        List<String> parts = dateString.split('T');
        if (parts.length != 2) {
          // If we can't split properly, try to parse the string directly
          throw FormatException('Invalid date format');
        }

        String datePart = parts[0]; // This is already in YYYY-MM-DD format
        String timePart = parts[1].replaceAll('-', ':'); // Convert time separators

        // Combine date and time
        String normalizedDate = '$datePart $timePart';

        // Parse the normalized date string
        DateTime dateObj = DateTime.parse(normalizedDate);

        // Format to "17 Feb 2025"
        String formatted = DateFormat('dd MMM yyyy').format(dateObj);

        // Calculate date 4 months in future
        DateTime futureDate = DateTime(
          dateObj.year,
          dateObj.month + 4,
          dateObj.day,
          dateObj.hour,
          dateObj.minute,
          dateObj.second,
        );
        String futureFormatted = DateFormat('dd MMM yyyy').format(futureDate);
        print('Formatted: $formatted');

        return [formatted, futureFormatted];
      } catch (e) {
        // Handle parsing errors by returning a default or current date
        DateTime now = DateTime.now();
        String formatted = DateFormat('dd MMM yyyy').format(now);
        DateTime futureDate = DateTime(now.year, now.month + 4, now.day);
        String futureFormatted = DateFormat('dd MMM yyyy').format(futureDate);

        print('Error processing date: $dateString'); // For debugging
        return [formatted, futureFormatted];
      }
    }

    String surveyStartDate = processSurveyDate(surveyName)[0];
    print("SurveyStartDate: $surveyStartDate");

    return SurveyMetric(
      companyBenchmarks: convertBenchmarks(companyBenchmarksMap),
      ceoBenchmarks: convertBenchmarks(ceoBenchmarksMap),
      cSuiteBenchmarks: convertBenchmarks(cSuiteBenchmarksMap),
      employeeBenchmarks: convertBenchmarks(employeeBenchmarksMap),
      diffScores: convertBenchmarks(diffScoresMap),
      nCeoFinished: nCeoFinished,
      nCSuiteFinished: nCSuiteFinished,
      nEmployeeFinished: nEmployeeFinished,
      nSurveys: nSurveys,
      nStarted: nStarted,
      nSubmitted: nCeoFinished + nCSuiteFinished + nEmployeeFinished,
      surveyDevName: surveyName,
      surveyStartDate: surveyStartDate,
      unableToCalculate: companyBenchmarksMap.isEmpty ? true : false,
    );
  }

  double get getSurveyParticipation => double.parse((nSubmitted * 100 / nSurveys).toStringAsFixed(1));
  bool get readyToDisplay => getSurveyParticipation >= 70 && unableToCalculate == false;
  String get getSurveyStartDate => surveyStartDate;

  List<Map<Indicator, double>> getSpecificFoundations(List<Indicator> indicators) {
    List<Map<Indicator, double>> foundationIndicators = [];

    for (var indicator in indicators) {
      if (companyBenchmarks.containsKey(indicator)) {
        foundationIndicators.add({indicator: companyBenchmarks[indicator]!});
      }
    }

    return foundationIndicators;
  }

  Map<Indicator, double> returnJustIndicators(String mapName) {
    Map<Indicator, double> removeIndicators(Map<Indicator, double> originalMap) {
      // Create a new map instead of modifying the reference
      Map<Indicator, double> returnMap = Map.from(originalMap);

      // List of indicators to remove
      final indicatorsToRemove = [
        Indicator.align,
        Indicator.people,
        Indicator.process,
        Indicator.leadership,
        Indicator.companyIndex,
        Indicator.workforce,
        Indicator.operations,
      ];

      // Remove all specified indicators
      for (final indicator in indicatorsToRemove) {
        returnMap.remove(indicator);
      }
      return returnMap;
    }

    // Get the appropriate map based on mapName
    Map<Indicator, double> sourceMap;
    switch (mapName) {
      case 'ceoBenchmarks':
        sourceMap = cSuiteBenchmarks;
        break;
      case 'cSuiteBenchmarks':
        sourceMap = cSuiteBenchmarks;
        break;
      case 'employeeBenchmarks':
        sourceMap = employeeBenchmarks;
        break;
      case 'diffScores':
        sourceMap = diffScores;
        break;
      case 'companyBenchmarks':
        sourceMap = companyBenchmarks;
        break;
      default:
        return {};
    }

    return removeIndicators(sourceMap);
  }

  List<Indicator> getHighestDiffIndicators(int n) {
    List<MapEntry<Indicator, double>> sortedEntries = returnJustIndicators('diffScores').entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    List<Indicator> indicators = [];
    for (var diff in sortedEntries.take(n)) {
      indicators.add(diff.key);
    }
    return indicators;
  }

  Indicator getLowestScoreIndicator() {
    List<MapEntry<Indicator, double>> benchmarkEntries = returnJustIndicators('companyBenchmarks').entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    return benchmarkEntries.first.key;
  }

  Indicator getHighestScoreIndicator() {
    List<MapEntry<Indicator, double>> benchmarkEntries = returnJustIndicators('companyBenchmarks').entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return benchmarkEntries.first.key;
  }

  List<Indicator> returnImpactChartIndicators() {
    List<Indicator> indicators = [];

    // Handle diff scores
    List<MapEntry<Indicator, double>> sortedEntries = returnJustIndicators('diffScores').entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    // Get top 3 indicators with value > 15
    for (var diff in sortedEntries.take(3)) {
      if (diff.value > 15) {
        indicators.add(diff.key);
      }
    }

    // Handle company benchmarks
    List<MapEntry<Indicator, double>> benchmarkEntries = returnJustIndicators('companyBenchmarks').entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    // Filter out indicators that are already selected
    benchmarkEntries.removeWhere((entry) => indicators.contains(entry.key));

    // Add remaining indicators up to a total of 6
    for (var indicator in benchmarkEntries.reversed.take(6 - indicators.length)) {
      indicators.add(indicator.key);
    }

    return indicators;
  }

  Map<String, dynamic> toMap() => {
        'companyBenchmarks': companyBenchmarks,
        'ceoBenchmarks': ceoBenchmarks,
        'cSuiteBenchmarks': cSuiteBenchmarks,
        'employeeBenchmarks': employeeBenchmarks,
        'diffScores': diffScores,
        'nCeoFinished': nCeoFinished,
        'nCSuiteFinished': nCSuiteFinished,
        'nEmployeeFinished': nEmployeeFinished,
        'nSurveys': nSurveys,
        'nStarted': nStarted,
        'nSubmitted': nSubmitted,
        'surveyName': surveyDevName,
        'notEnoughData': unableToCalculate,
      };

  void printData() {
    print('SurveyMetric Data:');
    print('Survey Name: $surveyDevName');
    print('Not Enough Data: $unableToCalculate');
    print('Number of Surveys Finished:');
    print('  CEO: $nCeoFinished');
    print('  C-Suite: $nCSuiteFinished');
    print('  Employees: $nEmployeeFinished');
    print('  Total Surveys: $nSurveys');
    print('  Surveys Started: $nStarted');

    print('\nBenchmarks:');
    print('  CEO Benchmarks:');
    ceoBenchmarks.forEach((key, value) {
      print('    $key: $value');
    });
    print('  C-Suite Benchmarks:');
    cSuiteBenchmarks.forEach((key, value) {
      print('    $key: $value');
    });
    print('  Employee Benchmarks:');
    employeeBenchmarks.forEach((key, value) {
      print('    $key: $value');
    });
    print('  Company Benchmarks:');
    companyBenchmarks.forEach((key, value) {
      print('    $key: $value');
    });

    print('\nDifference Scores:');
    diffScores.forEach((key, value) {
      print('  $key: $value');
    });
  }
}

class MetricsData {
  Map<String, SurveyMetric> allSurveyMetrics; // Contains all old survey Data

  MetricsData._internal({
    required this.allSurveyMetrics,
  });

  // Singleton instance
  static final MetricsData _instance = MetricsData._internal(
    allSurveyMetrics: {},
  );

  List<String> getSurveyNames() {
    return allSurveyMetrics.keys.toList();
  }

  factory MetricsData() {
    return _instance;
  }

  void addSurveyData(SurveyMetric surveyMetric) {
    allSurveyMetrics[surveyMetric.surveyDevName] = surveyMetric;
  }

  SurveyMetric getSurveyMetric(String surveyName) {
    return allSurveyMetrics[surveyName]!;
  }

  void printAllSurveyData() {
    allSurveyMetrics.forEach((key, value) {
      print('Survey Name: $key');
      print('Survey Data: ${value.toMap()}');
      print('-----------------------');
    });
  }

  void printSurveyData(String surveyName) {
    print('Survey Data: ${allSurveyMetrics[surveyName]?.toMap()}');
  }
}
