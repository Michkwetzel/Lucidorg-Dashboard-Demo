// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/sideBar/sections/overviewSBResults.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class ResultsSideBar extends ConsumerWidget {
  const ResultsSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultSection selectedSection = ref.watch(resultsSelectedSectionProvider);

    Widget _returnSideBarWidget(){
      switch (selectedSection){
        case ResultSection.overview:
          return OverViewSBResults();
        default:
          return OverViewSBResults();
      }
        
    }

    return Container(
      margin: EdgeInsets.only(left: 5, bottom: 5),
      width: 350,
      height: 822,
      decoration: kboxShadowNormal,
      child: _returnSideBarWidget(),
    );
  }
}
