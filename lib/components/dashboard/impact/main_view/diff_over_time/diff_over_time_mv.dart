import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/impact/main_view/score_over_time/score_over_time_MV.dart';

class DiffOverTimeMv extends StatelessWidget {
  const DiffOverTimeMv({super.key});

  @override
  Widget build(BuildContext context) {
    return ScoreOverTimeMV(scores: false);
  }
}