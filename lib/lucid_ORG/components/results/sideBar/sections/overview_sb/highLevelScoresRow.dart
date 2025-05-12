// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/components/global_org/score_boxes/diff_box.dart';
import 'package:platform_front/lucid_ORG/components/global_org/score_boxes/score_box.dart';

class HighLevelScoresRow extends ConsumerWidget {
  final String category;
  final double score;
  final double diff;

  const HighLevelScoresRow({
    super.key,
    required this.category,
    required this.score,
    required this.diff,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 120,
          child: Text(category, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
        ),
        ScoreBox(height: 40, width: 60, score: score, textSize: 15, fontWeight: FontWeight.w300),
        DiffBox(height: 40, width: 60, diff: diff, textSize: 15, fontWeight: FontWeight.w300)
      ],
    );
  }
}
