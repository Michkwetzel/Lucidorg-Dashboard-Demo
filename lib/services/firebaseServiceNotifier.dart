import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/exceptions.dart';

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

}
