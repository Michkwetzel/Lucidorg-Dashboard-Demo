import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/resultsBody.dart';

class ResultsSideDisplaynotifer extends StateNotifier<Widget> {
  ResultsSideDisplaynotifer() : super(const ResultsSideOverview());

  void setDisplay(Widget display){
    state = display;
  }
}
