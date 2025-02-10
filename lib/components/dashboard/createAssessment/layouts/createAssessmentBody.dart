import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailTemplate/emailTemplateBody.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class CreateAssessmentBody extends ConsumerStatefulWidget {
  CreateAssessmentBody({
    super.key,
  });

  @override
  ConsumerState<CreateAssessmentBody> createState() => _CreateAssessmentBodyState();
}

class _CreateAssessmentBodyState extends ConsumerState<CreateAssessmentBody> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final Logger logger = Logger('CreateAssessment');

  void startAssessment(BuildContext context, WidgetRef ref) async {
    logger.info('Staring Assessment');
    if (ref.read(emailTemplateProvider.notifier).editEmailTemplateDisplay) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Save Email Template'),
          backgroundColor: Colors.red,
        ),
      );
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
    } else {
      try {
        await ref.read(googlefunctionserviceProvider.notifier).createAssessment();
        SnackBarService.showMessage('Successfully Created assessment', Colors.green);
      } on Exception catch (e) {
        SnackBarService.showMessage('Error creating Assessment', Colors.red);
        logger.severe("Failed to create Assessment with error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingOverlay(
      loadingProvider: ref.watch(googlefunctionserviceProvider),
      loadingMessage: 'Creating Assessment!',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 380,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed header section

                  const SizedBox(height: 12),
                  const Text(
                    'Create Assessment',
                    style: kH1TextStyle,
                  ),
                  const SizedBox(height: 40),

                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Emaillistbody(),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CallToActionButton(
                                disabled: ref.watch(googlefunctionserviceProvider),
                                onPressed: () => startAssessment(context, ref),
                                buttonText: "Start Assessment",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
            const Padding(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              child: EmailTemplateBody(),
            ),
            TextButton(
                onPressed: () async {
                  await ref.read(metricsDataProvider.notifier).getSurveyData(ref.read(userDataProvider.notifier).companyUID ?? 'Hello');
                  MetricsData alldata = MetricsData();
                  alldata.printAllSurveyData();
                },
                child: Text("Get Survey Data"))
          ],
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
