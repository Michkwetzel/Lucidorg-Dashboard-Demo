import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final metricsStreamProvider = StreamProvider.autoDispose.family<DocumentSnapshot<Map<String, dynamic>>, List<String>>((ref, args) {
  final companyUID = args[0];
  final latestSurveyDocName = args[1];

  return FirebaseFirestore.instance.collection('surveyMetrics/$companyUID/$latestSurveyDocName').doc('metrics').snapshots();
});

final participationStreamProvider = StreamProvider.autoDispose.family<DocumentSnapshot<Map<String, dynamic>>, List<String>>((ref, args) {
  final companyUID = args[0];
  final latestSurveyDocName = args[1];

  return FirebaseFirestore.instance.collection('surveyMetrics/$companyUID/$latestSurveyDocName').doc('participationStats').snapshots();
});

// NOT USED