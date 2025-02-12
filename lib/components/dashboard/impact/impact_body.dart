// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/impact/main_view/impact_main_view.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/impact_side_bar.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class ImpactBody extends ConsumerWidget {
  const ImpactBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LoadingOverlay(
      loadingProvider: ref.watch(metricsDataProvider).loading,
      showChild: false,
      child: const Padding(
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
                              "Impact",
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
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 32,
                    children: [
                      ImpactSideBar(),
                      ImpactMainView(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
