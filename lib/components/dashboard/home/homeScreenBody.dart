import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/home/Sections/participation_widget.dart';
import 'package:platform_front/components/dashboard/home/Sections/benchmarkWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/nextAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/topOppertunitiesWidget/TopOppertunitiesWidget.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/components/global/no_data_pop_up.dart';
import 'package:platform_front/components/global/no_data_top_banner.dart';
import 'package:platform_front/components/global/top_action_banner.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/survey_metrics_provider.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool blurWidgets = ref.watch(metricsDataProvider).participationBelow30;

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
                    width: 1008,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Home",
                          style: kH1TextStyle,
                        ),
                        if (!ref.watch(metricsDataProvider).noSurveyData)
                          Text(
                            'Assessment: Q1 2025',
                            style: kH5PoppinsLight,
                          )
                      ],
                    ),
                  ),
                  if (ref.watch(metricsDataProvider).noSurveyData || ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).participationBelow30) TopActionBanner(),
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
                    width: 1000,
                    height: 270,
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
                            BlurOverlay(
                              blur: blurWidgets,
                              child: NextAssessmentWidget(
                                nextAssessmentData: '24 Feb 2025',
                              ),
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
