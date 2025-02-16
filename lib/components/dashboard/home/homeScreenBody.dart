import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/home/Sections/activeAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/benchmarkWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/nextAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/topOppertunitiesWidget/TopOppertunitiesWidget.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/notifiers/surveyMetrics/metrics_data.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OverlayWidget(
      noSurveyData: ref.watch(metricsDataProvider).noSurveyData,
      notEnoughData: ref.watch(metricsDataProvider).notEnoughData,
      loadingProvider: ref.watch(metricsDataProvider).loading,
      showChild: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 1008,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Home",
                        style: kH1TextStyle,
                      ),
                      Text(
                        'Assessment: Q1 2025',
                        style: kH5PoppinsLight,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(children: [
                  const SizedBox(
                    width: 6,
                  ),
                  BlurOverlay(
                    blur: ref.watch(metricsDataProvider).surveyMetric.notEnoughData,
                    child: BenchmarkWidget()),
                  const SizedBox(width: 32),
                  ActiveAssessmentWidget(),
                  TextButton(
                      onPressed: () {
                        MetricsData alldata = MetricsData();
                        ref.read(metricsDataProvider.notifier).initializeDefault();
                      },
                      child: Text("Load default values"))
                ]),
                const SizedBox(height: 32),
                const SizedBox(
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
                          CurrentActionAreaWidget(),
                          NextAssessmentWidget(
                            nextAssessmentData: '24 Feb 2025',
                          )
                        ],
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      TopOppertunitiesWidget()
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
