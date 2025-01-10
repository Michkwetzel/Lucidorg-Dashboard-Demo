import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/providers.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ResultsStats();
  }
}

// 1. First, create a provider for your stream:
final resultsStreamProvider = StreamProvider.autoDispose.family<QuerySnapshot, ({String? assessmentId, String? companyId})>((ref, params) {
  print('AssessmentId: ${params.assessmentId}, CompanyId: ${params.companyId}');

  if (params.assessmentId == null) return Stream.empty();
  if (params.companyId == null) return Stream.empty();

  return FirebaseFirestore.instance.collection('surveyData/${params.companyId}/${params.assessmentId}/results/data').snapshots();
});

// 2. Then modify your ResultsStats widget:
class ResultsStats extends ConsumerWidget {
  final Logger logger = Logger('HomeLayout');

  ResultsStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestAssessment = ref.watch(activeAssessmentDataProvider.select((data) => data.docName));
    final companyUID = ref.watch(authfirestoreserviceProvider.select((data) => data.companyUID));

    final resultsStream = ref.watch(resultsStreamProvider((assessmentId: latestAssessment, companyId: companyUID)));

    if (latestAssessment == null || companyUID == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No assessment or company ID available'),
        ),
      );
    }

    return resultsStream.when(data: (snapshot) {
      logger.info('Got data with ${snapshot.docs.length} documents');
      if (snapshot.docs.isEmpty) {
        return const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('No results available'),
          ),
        );
      }

      final docs = snapshot.docs;
      final totalDocs = docs.length;
      final startedCount = docs.where((doc) => doc['started'] == true).length;
      final finishedCount = docs.where((doc) => doc['finished'] == true).length;

      return Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Documents: $totalDocs'),
              Text('Started: $startedCount'),
              Text('Finished: $finishedCount'),
            ],
          ),
        ),
      );
    }, loading: () {
      logger.info('Loading results state');
      return const Center(child: Text('Isloading'));
    }, error: (error, stack) {
      logger.severe('error: $error');
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Error: $error'),
        ),
      );
    });
  }
}
