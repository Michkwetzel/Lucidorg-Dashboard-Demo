// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/mainView/mainViewBody.dart';
import 'package:platform_front/components/dashboard/results/sideBar/resultsSideBarBody.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/components/global/no_data_top_banner.dart';
import 'package:platform_front/components/global/top_action_banner.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

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
                    Row(
                      children: [
                        SizedBox(
                          width: 1008,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Results",
                                style: kH1TextStyle,
                              ),
                              Text(
                                'Assessment: Q1 2025',
                                style: kH5PoppinsLight,
                              )
                            ],
                          ),
                        ),
                      ],
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
