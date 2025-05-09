// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/global_components/blur_overlay.dart';
import 'package:platform_front/lucid_ORG/components/focus/focus_content/focus_content_widget.dart';
import 'package:platform_front/lucid_ORG/components/focus/action_bar/focus_action_bar.dart';
import 'package:platform_front/global_components/loading_overlay.dart';
import 'package:platform_front/lucid_ORG/components/global_org/top_action_banner.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class FocusBody extends ConsumerWidget {
  const FocusBody({super.key});

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
                    "Focus",
                    style: kH1TextStyle,
                  ),
                  if (ref.watch(metricsDataProvider).noSurveyData ||
                      ref.watch(metricsDataProvider).participationBelow30 ||
                      ref.watch(metricsDataProvider).between30And70 ||
                      ref.watch(metricsDataProvider).needAll3Departments ||
                      ref.watch(metricsDataProvider).testData)
                    TopActionBanner(
                      section: DashboardSection.impact,
                    ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 1520,
                    padding: EdgeInsets.all(32),
                    margin: EdgeInsets.only(left: 5, bottom: 5, right: 5),
                    decoration: kboxShadowNormal,
                    child: Column(
                      children: [
                        FocusActionBar(),
                        BlurOverlay(
                          blur: ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).needAll3Departments,
                          child: FocusContentWidget(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
