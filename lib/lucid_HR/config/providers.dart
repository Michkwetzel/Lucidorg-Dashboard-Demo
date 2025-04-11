import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/notifiers/job_creation_notifier.dart';

final jobCreationProvider = StateNotifierProvider<JobCreationNotifier, JobCreationState>((ref) {
  return JobCreationNotifier();
});
