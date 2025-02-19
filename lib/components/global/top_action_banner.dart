import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/notifiers/surveyMetrics/survey_metrics_provider.dart';
import 'package:platform_front/services/microServices/navigationService.dart';

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

    // Change to direct function instead of void function
    void handlePress() {
      if (metricsState.noSurveyData) {
        ref.read(navBarProvider.notifier).changeDisplay(NavBarButtonType.createAssessment);
        NavigationService.navigateTo('/createAssessment');
      } else if (metricsState.participationBelow30) {
        // Add your reminder sending logic here
        print('Sending reminder...');
      } else {
        print('Can send another Reminder.');
      }
    }

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
    }

    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 8),
      child: Container(
        width: 1000,
        decoration: BoxDecoration(
          color: Colors.white,
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
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 18, color: Colors.black87),
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
