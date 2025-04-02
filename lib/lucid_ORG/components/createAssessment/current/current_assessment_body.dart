import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/current/current_email_list_body.dart';
import 'package:platform_front/lucid_ORG/components/createAssessment/current/reminder_email.template.dart';
import 'package:platform_front/global_components/grayDivider.dart';
import 'package:platform_front/lucid_ORG/components/global_org/top_action_banner.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class CurrentAssessmentBody extends ConsumerWidget {
  const CurrentAssessmentBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            const Text(
              'Current Assessment',
              style: kH1TextStyle,
            ),
            if (ref.watch(metricsDataProvider).noSurveyData || ref.watch(metricsDataProvider).testData)
              TopActionBanner(
                section: DashboardSection.currentAssessment,
              ),
            SizedBox(
              height: 24,
            ),
            Row(
              spacing: 32,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 380,
                  ),
                  child: const CurrentEmaillistbody(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sent: ${ref.watch(metricsDataProvider).surveyMetric.surveyStartDate}", style: kH3TextStyle),
                      SizedBox(height: 12),
                      Text("Number of emails sent: ${ref.read(currentEmailListProvider.notifier).getTotalEmails()}", style: kH3TextStyle),
                      SizedBox(height: 20),
                      GrayDivider(width: 570),
                      SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: ReminderEmailTemplateBody(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
