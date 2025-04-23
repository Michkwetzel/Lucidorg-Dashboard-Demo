// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/mainViewBody.dart';
import 'package:platform_front/lucid_ORG/components/results/sideBar/resultsSideBarBody.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/lucid_ORG/components/global_org/no_data_top_banner.dart';
import 'package:platform_front/lucid_ORG/components/global_org/top_action_banner.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class ResultsBody extends ConsumerWidget {
  const ResultsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OverlayWidget(
      loadingProvider: ref.watch(metricsDataProvider).loading,
      showChild: false,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Results",
                      style: kH1TextStyle,
                    ),
                    if (ref.watch(metricsDataProvider).noSurveyData ||
                        ref.watch(metricsDataProvider).participationBelow30 ||
                        ref.watch(metricsDataProvider).between30And70 ||
                        ref.watch(metricsDataProvider).needAll3Departments ||
                        ref.watch(metricsDataProvider).testData)
                      TopActionBanner(
                        section: DashboardSection.results,
                      ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 32,
                      children: [ResultsSideBar(), MainViewBody()],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
