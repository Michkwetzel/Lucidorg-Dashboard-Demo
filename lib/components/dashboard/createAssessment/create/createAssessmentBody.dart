import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/global/buttons/CallToActionButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/emailTemplateBody.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/components/global/top_action_banner.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/services/microServices/alertService.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class CreateAssessmentBody extends ConsumerStatefulWidget {
  CreateAssessmentBody({
    super.key,
  });

  @override
  ConsumerState<CreateAssessmentBody> createState() => _CreateAssessmentBodyState();
}

class _CreateAssessmentBodyState extends ConsumerState<CreateAssessmentBody> {
  final Logger logger = Logger('CreateAssessment');

  void startAssessment(BuildContext context, WidgetRef ref) async {
    logger.info('Staring Assessment');
    if (ref.read(userDataProvider.notifier).permission == Permission.guest) {
      if (ref.read(emailListProvider.notifier).moreThan5Emails) {
        AlertService.showAlert(title: "More than 5 emails", message: "This is a guest account and thus limited to max 5 emails. Please remove some emails from the list");
      } else if (ref.read(emailListProvider.notifier).emailsEmpty) {
        SnackBarService.showMessage('Email list Empty', Colors.red, duration: 3);
      } else {
        try {
          await ref.read(googlefunctionserviceProvider.notifier).createAssessment(guest: true);
          AlertService.showAlert(
              title: "Test Assessment sent",
              message: "An assessment has been sent to the relevent emails. This is for viewing purpouses only and results will not be saved or influence this dashboard");
        } on Exception catch (e) {
          SnackBarService.showMessage('Error creating Assessment, Please try again or reload webpage', Colors.red, duration: 4);
          logger.severe("Failed to create Assessment with error: $e");
        }
      }
    } else if (ref.read(emailListProvider.notifier).emailsEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email list Empty'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (ref.read(companyInfoProvider.notifier).companyInfoEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter details in Company Info Page'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (ref.read(emailTemplateProvider.notifier).editEmailTemplateDisplay) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Save Email Template'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        await ref.read(googlefunctionserviceProvider.notifier).createAssessment();
        AlertService.showAlert(message: 'Successfully Created assessment', title: 'Success');
        await ref.read(userDataProvider.notifier).getUserInfo(ref.read(authfirestoreserviceProvider));
        await ref.read(metricsDataProvider.notifier).getSurveyData();
        await ref.read(currentEmailListProvider.notifier).getCurrentEmails();
      } on Exception catch (e) {
        SnackBarService.showMessage('Error creating Assessment', Colors.red, duration: 3);
        logger.severe("Failed to create Assessment with error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlayWidget(
      loadingProvider: ref.watch(googlefunctionserviceProvider).loading,
      loadingMessage: "Creating Assessment!",
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
                'Create Assessment',
                style: kH1TextStyle,
              ),
              if (ref.watch(metricsDataProvider).noSurveyData ||
                  ref.watch(metricsDataProvider).participationBelow30 ||
                  ref.watch(metricsDataProvider).between30And70 ||
                  ref.watch(metricsDataProvider).needAll3Departments ||
                  ref.watch(metricsDataProvider).testData)
                TopActionBanner(),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Emaillistbody(),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CallToActionButton(
                                  disabled: ref.watch(googlefunctionserviceProvider).loading,
                                  onPressed: () => startAssessment(context, ref),
                                  buttonText: "Start Assessment",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: EmailTemplateBody(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // int counter = 0;
    // List<int> tempNumbers = [];
    // Map<String, int> tempMap = {};
    // Map<String, Map<String, int>> finalMap = {};

    // List<String> terms = [
    //   "align",
    //   "leadership",
    //   "people",
    //   "process",
    //   "general",
    //   "alignedOrgStruct",
    //   "alignedTech",
    //   "collabKPIs",
    //   "collabProcess",
    //   "crossAcc",
    //   "crossComms",
    //   "empoweredLeadership",
    //   "engagedCommunity",
    //   "growthAlign",
    //   "index",
    //   "meetingEfficacy",
    //   "purposeDriven",
    //   "operations",
    //   "workforce"
    // ];
    // int counter2 = 0;
    // for (final number in numbers) {
    //   counter++;

    //   tempNumbers.add(number);
    //   if (counter == 19) {
    //     counter2++;
    //     for (int i = 0; i < tempNumbers.length; i++) {
    //       tempMap[terms[i]] = tempNumbers[i];
    //     }
    //     counter = 0;
    //     finalMap['survey$counter2'] = tempMap;
    //     tempMap = {};
    //     tempNumbers = [];
    //   }
    // }
    // void printFinalMap(Map<String, Map<String, int>> finalMap) {
    //   for (var entry in finalMap.entries) {
    //     print('${entry.key}:');
    //     entry.value.forEach((key, value) {
    //       print('  $key: $value');
    //     });
    //     print(''); // Add spacing between surveys
    //   }
    // }

    // printFinalMap(finalMap);
  }
}
