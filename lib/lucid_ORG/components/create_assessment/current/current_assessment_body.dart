import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/lucid_ORG/components/create_assessment/current/current_email_list_body.dart';
import 'package:platform_front/lucid_ORG/components/create_assessment/current/reminder_email.template.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_ORG/components/global_org/top_action_banner.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/services/microServices/alertService.dart';

class CurrentAssessmentBody extends ConsumerWidget {
  const CurrentAssessmentBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OverlayWidget(
      loadingProvider: ref.watch(googlefunctionserviceProvider).loading,
      loadingMessage: "Sending Reminder!",
      child: SingleChildScrollView(
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
                    child: SizedBox(
                      width: 800,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sent: ${ref.watch(metricsDataProvider).surveyMetric.surveyStartDate}", style: kH3TextStyle),
                          SizedBox(height: 12),
                          Text("Number of emails sent: ${ref.read(currentEmailListProvider.notifier).getTotalEmails()}", style: kH3TextStyle),
                          SizedBox(height: 20),
                          ReminderTemplateWidget_ORG(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CallToActionButton(
                                  onPressed: ref.read(userDataProvider.notifier).permission == Permission.guest
                                      ? null
                                      : () async {
                                          if (ref.read(reminderEmailTemplateProvider.notifier).validateAllData()) {
                                            await ref.read(googlefunctionserviceProvider.notifier).sendEmailReminder();
                                            AlertService.showAlert(title: 'Sent Reminder', message: "A reminder with the survey link has been sent");
                                          }
                                        },
                                  buttonText: 'Send Reminder'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
