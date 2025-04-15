import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/config/enums_hr.dart';
import 'package:platform_front/lucid_HR/config/providers.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/benchmark_widgets/benchmarks_widget.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/email_template/email_template_widget.dart';

class JobSearchDynamicSection extends ConsumerWidget {
  const JobSearchDynamicSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(jobCreationProvider.select((state) => state.newJobSearchSection)) == NewJobSearchSection.chooseBenchmarks) {
      return BenchmarksWidget();
    } else {
      return EmailTemplateWidget();
    }
  }
}
