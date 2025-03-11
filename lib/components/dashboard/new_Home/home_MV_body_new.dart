import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/new_Home/home_MV.dart';
import 'package:platform_front/components/dashboard/new_Home/home_top_button_row.dart';
import 'package:platform_front/components/dashboard/results/mainView/components/resultsTopButtonRow.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/indicators/indicators_main_view.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/diff_matrix/diff_matrix_body.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/over_view/overview_main_body.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/foundations/foundations_body.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class HomeMvBodyNew extends ConsumerWidget {
  const HomeMvBodyNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeSection selectedSection = ref.watch(selectedHomeDisplayProvider);

    Widget returnMainViewWidget() {
      switch (selectedSection) {
        case HomeSection.home:
          return HomeMV();
        case HomeSection.currentAssessment:
        //return IndicatorSideBar();
        case HomeSection.newAssessment:
        //     return DiffMatrixSideBar();
        case HomeSection.howTo:
        //  return FoundationsSB();
        default:
          return Container();
      }
    }

    return Container(
      width: 900,
      padding: EdgeInsets.all(32),
      margin: EdgeInsets.only(left: 5, bottom: 5, right: 5),
      decoration: kboxShadowNormal,
      child: Column(
        children: [
          HomeTopButtonRow(),
          SizedBox(
            height: 32,
          ),
          returnMainViewWidget(),
        ],
      ),
    );
  }
}
