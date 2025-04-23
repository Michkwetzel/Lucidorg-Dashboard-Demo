import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/config/enums_hr.dart';
import 'package:platform_front/lucid_HR/config/providers_hr.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/email_list_widgets/add_emails_widget_hr.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/email_list_widgets/email_list_view_h_r.dart';

class Emaillistbody extends ConsumerWidget {
  const Emaillistbody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(jobCreationProvider).emailListDisplay == EmailListDisplay.empty) {
      return Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 500,
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Padding(padding: const EdgeInsets.all(24.0), child: ref.watch(jobCreationProvider).emailListDisplay == EmailListDisplay.add ? AddEmailsWidgetHR() : EmailListViewHR()),
          ),
          Text(
            "Please add at least one email address",
            style: TextStyle(color: Colors.red),
          ),
        ],
      );
    }
    return Container(
      height: 500,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF555353), width: 0.7),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(padding: const EdgeInsets.all(24.0), child: ref.watch(jobCreationProvider).emailListDisplay == EmailListDisplay.add ? AddEmailsWidgetHR() : EmailListViewHR()),
    );
  }
}
