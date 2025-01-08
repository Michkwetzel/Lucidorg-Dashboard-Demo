import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/providers.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(16),
      // ),
      child: ResultsStats(),
    );
  }
}

class ResultsStats extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<Stream<QuerySnapshot>>(
      future: ref.read(googlefunctionserviceProvider.notifier).getResultsStream(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasError) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Error loading stream: ${streamSnapshot.error}'),
            ),
          );
        }

        if (!streamSnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return StreamBuilder<QuerySnapshot>(
          stream: streamSnapshot.data,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Stream error: ${snapshot.error}'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data?.docs ?? [];
            final totalDocs = docs.length;
            final startedCount = docs.where((doc) => doc['started'] == true).length;
            final finishedCount = docs.where((doc) => doc['finished'] == true).length;

            return Card(
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
          },
        );
      },
    );
  }
}
