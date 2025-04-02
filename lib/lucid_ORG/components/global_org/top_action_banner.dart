import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/survey_metrics_provider.dart';
import 'package:platform_front/lucid_ORG/services/microServices/navigationService.dart';

class TopActionBanner extends ConsumerWidget {
  final DashboardSection section;
  const TopActionBanner({
    required this.section,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MetricsDataState metricsState = ref.watch(metricsDataProvider);

    double participation = metricsState.surveyMetric.getSurveyParticipation;

    // Default of no Survey sent out yet.
    String text = "No assessment Data Available. Numbers below are demo data. Please create assessment to view results";
    String buttonText = "Create Assessment";
    Color borderColor = Colors.orange[300]!;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black87;

    // Create Assessment only needs banner during no survey, test account and not able to send an assessment.
    if (section == DashboardSection.createAssessment) {
      if (metricsState.testData) {
        text = "Hi and Welcome to LucidORG! As a guest you can view dummy results and send an assessment to max 5 emails. Note results from this assessment are not saved or used in this dashboard.";
        buttonText = "Contact LucidORG";
        textColor = Color(0xFFDD1155);
        borderColor = Color(0xFFBEBEBE);
        backgroundColor = Colors.white;
      } else if (!metricsState.canSendNewAssessment) {
        SurveyMetric metric = metricsState.surveyMetric;
        String startDate = metric.surveyStartDate;

        DateTime date = DateFormat("d MMM yyy").parse(startDate);

        // Now you can add months
        DateTime newDate = DateTime(date.year, date.month + 1, date.day);

        // Format back to string if needed
        String newDateString = DateFormat("d MMM yyyy").format(newDate);
        text = "Assessments are limited to one per month. You can send another assessment after: $newDateString";
        buttonText = "Send Reminder";
        borderColor = Colors.purple[300]!;
      }
    } else if (section == DashboardSection.currentAssessment) {
      if (metricsState.testData) {
        text = "Hi and Welcome to LucidORG! As a guest you can view dummy results and send an assessment to max 5 emails. Note results from this assessment are not saved or used in this dashboard.";
        buttonText = "Contact LucidORG";
        textColor = Color(0xFFDD1155);
        borderColor = Color(0xFFBEBEBE);
        backgroundColor = Colors.white;
      }
    } else {
      if (metricsState.participationBelow30) {
        text = "Current Assessment participation is $participation%. We need 30% to show data";
        buttonText = "Send Reminder";
        borderColor = Colors.purple[300]!;
      } else if (metricsState.between30And70) {
        text = "Current Assessment participation: $participation%. Values are not accurate until 70%";
        buttonText = "Send Reminder";
        borderColor = Colors.purple[300]!;
      } else if (metricsState.needAll3Departments) {
        SurveyMetric latestSurvey = MetricsData().getSurveyMetric(ref.read(userDataProvider).latestSurveyDocName!);
        double nCeoFinished = latestSurvey.nCeoFinished;
        double nCSuiteFinished = latestSurvey.nCSuiteFinished;
        double nEmployeeFinished = latestSurvey.nEmployeeFinished;

        String missing = "";
        if (nCeoFinished == 0) {
          missing = "CEO";
        } else if (nEmployeeFinished == 0) {
          missing = "Staff";
        } else if (nCSuiteFinished == 0) {
          missing = "C-Suite";
        }

        text = "We need at least 1 result from each department. Missing department: $missing";
        buttonText = "Send Reminder";
        borderColor = Colors.purple[300]!;
      } else if (metricsState.testData) {
        text = "Hi and Welcome to LucidORG! As a guest you can view dummy results and send an assessment to max 5 emails. Note results from this assessment are not saved or used in this dashboard.";
        buttonText = "Contact LucidORG";
        textColor = Color(0xFFDD1155);
        borderColor = Color(0xFFBEBEBE);
        backgroundColor = Colors.white;
      } else if (!metricsState.canSendNewAssessment) {
        text = "Assessments are limited to one per month. You can send another assessment after:";
        buttonText = "Send Reminder";
        borderColor = Colors.purple[300]!;
      }
    }

    void handlePress() async {
      if (metricsState.noSurveyData) {
        ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.createAssessment);
        NavigationService.navigateTo('/createAssessment');
      } else if (metricsState.testData) {
        html.window.open("https://www.lucidorg.com/contact", '_blank');
      } else {
        ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.currentAssessment);
        NavigationService.navigateTo('/currentAssessment');
        ref.read(toggleSubMenuProvider.notifier).expand();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 8),
      child: Container(
        width: 1047,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 18, color: textColor),
                ),
              ),
              CallToActionButton(onPressed: handlePress, buttonText: buttonText),
            ],
          ),
        ),
      ),
    );
  }
}
