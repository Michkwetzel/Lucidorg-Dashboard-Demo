import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/participation_widget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/benchmarkWidget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/nextAssessmentWidget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/topOppertunitiesWidget/top_opp_widget.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/lucid_ORG/components/global_org/no_data_pop_up.dart';
import 'package:platform_front/lucid_ORG/components/global_org/top_action_banner.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/components/new_home/home_high_level.dart';
import 'package:platform_front/lucid_ORG/components/new_home/home_indicator.dart';
import 'package:platform_front/lucid_ORG/components/new_home/new_home_widgets.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Stack(
              children: [
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
                    SizedBox(height: 16),
                    SizedBox(
                      width: 1400,
                      child: Column(
                        children: [
                          Text('Benchmark Overview', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 30)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BenchmarkWidget(),
                              SizedBox(height: 400, child: TotalScores()),
                              HomeHighLevelOverView(),
                              SizedBox(
                                width: 50,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: HomeRow3(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 150),
                              child: Text('Indicators', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 30)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 410),
                              child: Text('Differentiation Matrix', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 30)),
                            ),
                          ],
                        ),
                        HomeRow2(),
                      ],
                    ),
                  ],
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

class HomeRow3 extends StatelessWidget {
  const HomeRow3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1200,
      height: 350,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text('Focus Areas', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeFocusAreasWidget(
                section: FocusSection.diffPyramid,
              ),
              HomeFocusAreasWidget(
                section: FocusSection.scorePyramid,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HomeRow2 extends StatelessWidget {
  const HomeRow2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1400,
      child: Row(
        spacing: 40,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: HomeIndicators(),
          ),
          Column(
            children: [
              SizedBox(
                width: 760,
                height: 700,
                child: ClickableRadarChart(),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  LegendItem(department: Department.ceo, color: Colors.blue),
                  LegendItem(department: Department.cSuite, color: Colors.green),
                  LegendItem(department: Department.staff, color: Colors.red),
                ],
              ),
            ],
          ),
        ],
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
