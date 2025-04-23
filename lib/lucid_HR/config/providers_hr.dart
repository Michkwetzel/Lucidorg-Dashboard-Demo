import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/notifiers/job_creation_notifier.dart';
import 'package:platform_front/lucid_HR/notifiers/job_search_data/job_search_notifier.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

final jobCreationProvider = StateNotifierProvider<JobCreationNotifier, JobCreationState>((ref) {
  return JobCreationNotifier();
});

final jobSearchNotifier = StateNotifierProvider<JobSearchNotifier, JobSearchState>((ref) {
  final userDataNotifier = ref.watch(userDataProvider.notifier);
  return JobSearchNotifier(userInfo: userDataNotifier);
});
