import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/new_Home/home_sb.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class HomeSideBarBody extends ConsumerWidget {
  const HomeSideBarBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeSection selectedSection = ref.watch(selectedHomeDisplayProvider);

    Widget returnSideBarWidget() {
      switch (selectedSection) {
        case HomeSection.home:
          return HomeSB();
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
      margin: EdgeInsets.only(left: 5, bottom: 5),
      width: 350,
      decoration: kboxShadowNormal,
      child: returnSideBarWidget(),
    );
  }
}
