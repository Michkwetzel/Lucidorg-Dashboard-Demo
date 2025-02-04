// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/global/score_boxes/diff_box.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/constants.dart';

class HighLevelScoresRow extends StatelessWidget {
  final String category;
  final double score;
  final double diff;
  final bool highLevelScore;

  const HighLevelScoresRow({
    super.key,
    required this.category,
    required this.score,
    required this.diff,
    this.highLevelScore = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: highLevelScore ? 100 : 120,
          child: Text(category, style: TextStyle(color: Colors.black, fontSize: highLevelScore ? 17 : 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
        ),
        ScoreBox(height: 40, width: 60, score: score, textSize: 15, fontWeight: FontWeight.w300),
        DiffBox(height: 30, width: 52, diff: diff, textSize: 14, fontWeight: FontWeight.w300)
      ],
    );
  }
}

// With department scores

// import 'package:flutter/material.dart';
// import 'package:platform_front/config/constants.dart';

// class HighLevelScoresRow extends StatelessWidget {
//   final String category;
//   final String score;
//   final String diff;
//   final String ceo;
//   final String cSuite;
//   final String staff;

//   const HighLevelScoresRow({
//     super.key,
//     required this.category,
//     required this.score,
//     required this.diff,
//     required this.ceo,
//     required this.cSuite,
//     required this.staff,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           width: 95,
//           child: Text(category, style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
//         ),
//         Container(
//           width: 60,
//           height: 40,
//           decoration: kScoreGreenBox,
//           child: Center(child: Text('$score%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400))),
//         ),
//         SizedBox(
//           width: 95,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('$ceo%', style: TextStyle(color: Color(0xFF9FAE82), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
//               Text(' | ', style: TextStyle(color: Colors.black, fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
//               Text('$cSuite%', style: TextStyle(color: Color(0xFFB3A986), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
//               Text(' | ', style: TextStyle(color: Colors.black, fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
//               Text('$staff%', style: TextStyle(color: Color(0xFF7FAF8C), fontSize: 11, fontFamily: 'Poppins', fontWeight: FontWeight.w300))
//             ],
//           ),
//         ),
//         Container(
//           width: 52,
//           height: 30,
//           decoration: kDiffRedBox,
//           child: Center(child: Text('~$diff%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
//         )
//       ],
//     );
//   }
// }
