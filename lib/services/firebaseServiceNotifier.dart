import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/exceptions.dart';
import 'package:platform_front/notifiers/metrics_provider.dart';

class FirebaseServiceNotifier extends StateNotifier<bool> {
  //Direct firestore serices
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger logger = Logger("FirebaseServiceNotifier");

  FirebaseServiceNotifier() : super(true);

  Future<String?> getLatestAssessment(String? companyUID) async {
    if (companyUID == null) {
      return null;
    } //Should already be set up
    final companyDocSnapshot = await _firestore.collection('surveyData').doc(companyUID).get();

    if (!companyDocSnapshot.exists) {
      throw CompanyNotFoundException();
    }

    final data = companyDocSnapshot.data();
    return data?['latestSurvey'] as String?;
  }

  Future<Stream<QuerySnapshot>> getLatestResultsStream({required String? latestAssessment, required String? companyUID}) async {
    try {
      // Wait for Firestore to be ready, but don't terminate
      await _firestore.waitForPendingWrites();

      // Return the stream without terminating the connection
      if (latestAssessment == null) {
        return const Stream.empty();
      }

      return _firestore.collection('surveyData/$companyUID/$latestAssessment/results/data').snapshots();
    } catch (e) {
      print('Error in getResultsStream: $e');
      rethrow;
    }
  }

  Future<Map<String, String>?> getCompanyInfo(String? companyUID) async {
    try {
      if (companyUID == null) {
        throw CompanyNotFoundException();
      }

      final docSnapshot = await _firestore.collection('surveyData').doc(companyUID).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey('companyInfo')) {
          Map<String, String> companyInfoMap = (data['companyInfo'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value!.toString()));

          logger.info('Fetched companyInfo: $companyInfoMap');
          return companyInfoMap;
        } else {
          logger.info('No CompanyInfo for companyUID: $companyUID');
          return null;
        }
      } else {
        throw CompanyNotFoundException();
      }
    } catch (e) {
      logger.severe('Error fetching company Info: $e');
      return null;
    }
  }

  Future<void> writeToDB() async {
    _firestore.collection('testing').doc().set({'test': 'test'});
  }

  Future<void> readToDB() async {
    print(_firestore.collection('testing').doc().get().toString());
  }

  Future<void> getSurveyData(String companyUID) async {
    print(companyUID);
    final data = await _firestore.collection('surveyMetrics').doc(companyUID).get();
    final allSurveyNames = List<String>.from(data.data()?['allSurveyNames'] ?? []);
    print(allSurveyNames);
    MetricsData globalMetricsData = MetricsData();

    for (final surveyName in allSurveyNames) {
      print(surveyName);
      final metricsDoc = await _firestore.collection('surveyMetrics/$companyUID/$surveyName').doc('metrics').get();
      final participationDoc = await _firestore.collection('surveyMetrics/$companyUID/$surveyName').doc('participationStats').get();
      print('Here');

      final metricsData = metricsDoc.data() as Map<String, dynamic>;
      final participationData = participationDoc.data() as Map<String, dynamic>;
      print('Here');

      final SurveyMetric surveyData = SurveyMetric(
        cSuiteBenchmarks: (metricsData['cSuiteBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
        ceoBenchmarks: (metricsData['ceoBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
        employeeBenchmarks: (metricsData['employeeBenchmarks'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as num).toDouble())) ?? {},
        nCeoFinished: (metricsData['nCeoFinished'] as num?)?.toDouble() ?? 0.0,
        nCSuiteFinished: (metricsData['nCSuiteFinished'] as num?)?.toDouble() ?? 0.0,
        nEmployeeFinished: (metricsData['nEmployeeFinished'] as num?)?.toDouble() ?? 0.0,
        nSurveys: (participationData['nSurveys'] as num?)?.toDouble() ?? 0.0,
        nStarted: (participationData['nStarted'] as num?)?.toDouble() ?? 0.0,
        surveyName: surveyName,
      );

      globalMetricsData.addSurveyData(surveyData);
    }
  }
}
