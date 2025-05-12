import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row1/department_score_widget.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/lucid_ORG/components/global_org/no_data_pop_up.dart';
import 'package:platform_front/lucid_ORG/components/global_org/top_action_banner.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row1/home_row1.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row2/home_row2.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row3/home_row3.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row1/home_pilars.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row2/home_indicator.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row3/home_focus_areas.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/diff_matrix/legend_item.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/diff_matrix/scores_radar_chart.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 16, ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  width: 1250,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Home",
                              style: kH1TextStyle,
                            ),
                            if (!ref.read(metricsDataProvider).noSurveyData) ActiveAssessmentTextWidget()
                          ],
                        ),
                        if (ref.watch(metricsDataProvider).noSurveyData ||
                            ref.watch(metricsDataProvider).participationBelow30 ||
                            ref.watch(metricsDataProvider).between30And70 ||
                            ref.watch(metricsDataProvider).needAll3Departments ||
                            ref.watch(metricsDataProvider).testData)
                          TopActionBanner(
                            section: DashboardSection.home,
                          ),
                        SizedBox(height: 16),
                        HomeRow1(),
                        SizedBox(height: 40),
                        HomeRow3(),
                        SizedBox(height: 40),
                        HomeRow2(),
                      ],
                    ),
                  ),
                ),
                NoDataPopUp()
              ],
            ),
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
