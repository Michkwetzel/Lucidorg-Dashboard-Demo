import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/blueButton.dart';
import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/notifiers/surveyMetrics/survey_metrics_provider.dart';
import 'package:platform_front/services/microServices/alertService.dart';
import 'package:platform_front/services/microServices/navigationService.dart';
import 'package:url_launcher/url_launcher.dart';

class TopActionBanner extends ConsumerWidget {
  const TopActionBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MetricsDataState metricsState = ref.watch(metricsDataProvider);

    double participation = metricsState.surveyMetric.getSurveyParticipation;
    String text = "No assessment Data Available. Numbers below are demo data. Please create assessment to view results";
    String buttonText = "Create Assessment";
    Color borderColor = Colors.orange[300]!;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black87;

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
    }

    void handlePress() async {
      if (metricsState.noSurveyData) {
        ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.createAssessment);
        NavigationService.navigateTo('/createAssessment');
      } else if (metricsState.participationBelow30 || metricsState.between30And70 || metricsState.needAll3Departments) {
        try {
          ref.read(googlefunctionserviceProvider.notifier).sendEmailReminder();
          AlertService.showAlert(title: 'Sent Reminder', message: "A reminder with the survey link has been sent");
        } on Exception catch (e) {
          print("Error sending reminder");
        }
        print('Finished');
      } else if (metricsState.testData) {
        launchUrl(Uri.parse("https://www.lucidorg.com/contact"));
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 18, color: textColor),
                ),
              ),
              // Direct function call instead of arrow function
              CallToActionButton(onPressed: handlePress, buttonText: buttonText),
            ],
          ),
        ),
      ),
    );
  }
}
