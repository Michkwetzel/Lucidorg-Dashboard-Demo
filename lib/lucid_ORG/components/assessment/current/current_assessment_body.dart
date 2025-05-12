import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/lucid_ORG/components/assessment/current/current_email_list_body.dart';
import 'package:platform_front/lucid_ORG/components/assessment/current/send_reminder/reminder_email.template.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_ORG/components/assessment/emailList/emailListView/emailCard.dart';
import 'package:platform_front/lucid_ORG/components/global_org/top_action_banner.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/participation_widget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row1/department_score_widget.dart';
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
                  SentEmailList(),
                  ParticipationWidget(),
                  DepartmentScoreWidget(
                    section: DashboardSection.currentAssessment,
                  )
                ],
              ),
              SizedBox(
                height: 32,
              ),
              ReminderBody()
            ],
          ),
        ),
      ),
    );
  }
}

class SentEmailList extends ConsumerStatefulWidget {
  const SentEmailList({super.key});

  @override
  ConsumerState<SentEmailList> createState() => _SentEmailListState();
}

class _SentEmailListState extends ConsumerState<SentEmailList> {
  bool isExpandedCEO = false;
  bool isExpandedCSuite = false;
  bool isExpandedTeam = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email List',
            style: kH2TextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => setState(() {
              isExpandedCEO = !isExpandedCEO;
              isExpandedCSuite = false;
              isExpandedTeam = false;
            }),
            child: Row(
              children: [
                Text("CEO", style: kH5PoppinsLight),
                Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: isExpandedCEO ? 230 : 0,
            child: SingleChildScrollView(
              child: SizedBox(
                height: 230,
                child: ListView.builder(
                  itemCount: ref.watch(currentEmailListProvider).emailsCeo.length,
                  itemBuilder: (context, index) {
                    return EmailCard(
                      emailText: ref.watch(currentEmailListProvider).emailsCeo[index],
                      index: index,
                      display: AssessmentDisplay.current,
                    );
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              isExpandedCSuite = !isExpandedCSuite;
              isExpandedCEO = false;
              isExpandedTeam = false;
            }),
            child: Row(
              children: [
                Text("C-Suite", style: kH5PoppinsLight),
                Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: isExpandedCSuite ? 250 : 0,
            child: SingleChildScrollView(
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: ref.watch(currentEmailListProvider).emailsCSuite.length,
                  itemBuilder: (context, index) {
                    return EmailCard(
                      emailText: ref.watch(currentEmailListProvider).emailsCSuite[index],
                      index: index,
                      display: AssessmentDisplay.current,
                    );
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              isExpandedTeam = !isExpandedTeam;
              isExpandedCEO = false;
              isExpandedCSuite = false;
            }),
            child: Row(
              children: [
                Text("Team", style: kH5PoppinsLight),
                Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: isExpandedTeam ? 260 : 0,
            child: SingleChildScrollView(
              child: SizedBox(
                height: 260,
                child: ListView.builder(
                  itemCount: ref.watch(currentEmailListProvider).emailsEmployee.length,
                  itemBuilder: (context, index) {
                    return EmailCard(
                      emailText: ref.watch(currentEmailListProvider).emailsEmployee[index],
                      index: index,
                      display: AssessmentDisplay.current,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReminderBody extends ConsumerWidget {
  const ReminderBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 1200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDivider(),
          SizedBox(
            height: 18,
          ),
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
    );
  }
}
