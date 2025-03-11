import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/createAssessment/current/current_email_list_body.dart';
import 'package:platform_front/components/dashboard/createAssessment/current/reminder_email.template.dart';
import 'package:platform_front/components/global/top_action_banner.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

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
            if (ref.watch(metricsDataProvider).noSurveyData || ref.watch(metricsDataProvider).testData) TopActionBanner(),
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
                const Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 4),
                  child: ReminderEmailTemplateBody(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
