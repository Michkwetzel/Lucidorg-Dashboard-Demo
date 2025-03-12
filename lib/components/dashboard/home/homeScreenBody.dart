import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:platform_front/components/dashboard/home/Sections/participation_widget.dart';
import 'package:platform_front/components/dashboard/home/Sections/benchmarkWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/nextAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/topOppertunitiesWidget/TopOppertunitiesWidget.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/components/global/no_data_pop_up.dart';
import 'package:platform_front/components/global/top_action_banner.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool blurWidgets = ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).needAll3Departments;

    return OverlayWidget(
      loadingProvider: ref.watch(metricsDataProvider).loading,
      showChild: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 1060,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Home",
                          style: kH1TextStyle,
                        ),
                        if (!ref.read(metricsDataProvider).noSurveyData) ActiveAssessmentTextWidget()
                      ],
                    ),
                  ),
                  if (ref.watch(metricsDataProvider).noSurveyData ||
                      ref.watch(metricsDataProvider).participationBelow30 ||
                      ref.watch(metricsDataProvider).between30And70 ||
                      ref.watch(metricsDataProvider).needAll3Departments ||
                      ref.watch(metricsDataProvider).testData)
                    TopActionBanner(),
                  const SizedBox(height: 16),
                  Row(children: [
                    const SizedBox(
                      width: 6,
                    ),
                    BlurOverlay(
                      child: BenchmarkWidget(),
                      blur: blurWidgets,
                    ),
                    const SizedBox(width: 32),
                    ParticipationWidget(),
                  ]),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 6,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlurOverlay(
                              child: CurrentActionAreaWidget(),
                              blur: blurWidgets,
                            ),
                            if (!ref.watch(metricsDataProvider).noSurveyData)
                              BlurOverlay(
                                blur: blurWidgets,
                                child: NextAssessmentWidget(),
                              )
                          ],
                        ),
                        SizedBox(
                          width: 32,
                        ),
                        BlurOverlay(
                          child: TopOppertunitiesWidget(),
                          blur: blurWidgets,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
              NoDataPopUp()
            ]),
          ),
        ),
      ),
    );
  }
}

class ActiveAssessmentTextWidget extends ConsumerWidget {
  const ActiveAssessmentTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(metricsDataProvider).surveyMetric.surveyStartDate,
      style: kH5PoppinsLight,
    );
  }
}


// TextButton(
//                             onPressed: () async {
//                               final FirebaseFirestore firestore = FirebaseFirestore.instance;

//                               // Source document reference
//                               final sourceDocRef = firestore.collection('surveyMetrics/RhBs9nhOWigeGY8wVUEU/2025-02-20T13-09-06').doc('metrics');

//                               // Get the source document
//                               final docSnapshot = await sourceDocRef.get();

//                               if (docSnapshot.exists) {
//                                 // Extract data from source document
//                                 final data = docSnapshot.data()!;

//                                 // Extract specific fields
//                                 final cSuite = data['cSuiteBenchmarks'];
//                                 final ceo = data['ceoBenchmarks'];
//                                 final employee = data['employeeBenchmarks'];
//                                 final nCSuite = data['nCSuiteFinished'];
//                                 final nCeoSuite = data['nCeoFinished'];
//                                 final nEmployeeSuite = data['nEmployeeFinished'];

//                                 // Target document reference
//                                 final targetDocRef = firestore.collection('surveyMetrics/RhBs9nhOWigeGY8wVUEU/2025-03-20T13-09-06').doc('metrics');

//                                 // Set data in target document
//                                 await targetDocRef.set({
//                                   'cSuiteBenchmarks': cSuite,
//                                   'ceoBenchmarks': ceo,
//                                   'employeeBenchmarks': employee,
//                                   'nCSuiteFinished': nCSuite,
//                                   'nCeoFinished': nCeoSuite,
//                                   'nEmployeeFinished': nEmployeeSuite
//                                 });

//                                 print('Survey metrics successfully migrated');
//                               } else {
//                                 print('Source document does not exist');
//                               }
//                             },
//                             child: Text("Dev button")),