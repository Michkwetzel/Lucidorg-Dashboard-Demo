import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/participation_widget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/benchmarkWidget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/nextAssessmentWidget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/topOppertunitiesWidget/TopOppertunitiesWidget.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/lucid_ORG/components/global_org/no_data_pop_up.dart';
import 'package:platform_front/lucid_ORG/components/global_org/top_action_banner.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

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
                    TopActionBanner(
                      section: DashboardSection.home,
                    ),
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
                    SizedBox(width: 8,)
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