// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/components/highLevelScoresRow.dart';
import 'package:platform_front/components/dashboard/results/components/overallScoresRow.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';

class OverViewSBResults extends StatelessWidget {
  const OverViewSBResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Overall Score",
            style: kH2PoppinsLight,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '55.7%',
            style: kH3TotalScoreLight,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Overall Differentiation',
            style: kH3PoppinsLight,
          ),
          SizedBox(
            height: 8,
          ),
          DiffTriangleRedWidget(value: '~38%', size: Diffsize.H1),
          SizedBox(
            height: 40,
          ),
          Text(
            'High Level Scores',
            style: kH3PoppinsRegular,
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 95,
                child: Text('Category', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 13)),
              ),
              SizedBox(
                width: 60,
                child: Center(child: Text('Score', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14))),
              ),
              SizedBox(
                width: 52,
                child: Center(
                  child: Text('Diff', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Divider(color: Color(0xFFC7C7C7), thickness: 1),
          SizedBox(
            height: 12,
          ),
          HighLevelScoresRow(
            category: 'Alignment',
            score: '65.7',
            diff: '18',
          ),
          SizedBox(
            height: 12,
          ),
          HighLevelScoresRow(
            category: 'Process',
            score: '70.7',
            diff: '18',
          ),
          SizedBox(
            height: 12,
          ),
          HighLevelScoresRow(
            category: 'People',
            score: '45.7',
            diff: '18',
          ),
          SizedBox(
            height: 12,
          ),
          HighLevelScoresRow(
            category: 'Leadership',
            score: '56.7',
            diff: '18',
          ),
          SizedBox(
            height: 12,
          ),
          Divider(color: Color(0xFFC7C7C7), thickness: 1),
          SizedBox(
            height: 12,
          ),
          OverallScoresRow(
            category: 'Overall',
            score: '56.7',
            diff: '18',
          )
        ],
      ),
    );
  }
}

// With department scores:

// import 'package:flutter/material.dart';
// import 'package:platform_front/components/dashboard/results/components/highLevelScoresRow.dart';
// import 'package:platform_front/components/dashboard/results/components/overallScoresRow.dart';
// import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
// import 'package:platform_front/config/constants.dart';
// import 'package:platform_front/config/enums.dart';

// class OverViewSBResults extends StatelessWidget {
//   const OverViewSBResults({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "Overall Score",
//             style: kH2PoppinsLight,
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           Text(
//             '55.7%',
//             style: kH3TotalScoreLight,
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Text(
//             'Overall Differentiation',
//             style: kH3PoppinsLight,
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           DiffTriangleRedWidget(value: '~38%', size: Diffsize.H1),
//           SizedBox(
//             height: 40,
//           ),
//           Text(
//             'High Level Scores',
//             style: kH3PoppinsRegular,
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 95,
//                 child: Text('Category', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 13)),
//               ),
//               SizedBox(
//                 width: 60,
//                 child: Center(child: Text('Score', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14))),
//               ),
//               SizedBox(
//                 width: 95,
//                 child: Center(child: Text('CEO | C-Suite | Staff', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 9))),
//               ),
//               SizedBox(
//                 width: 52,
//                 child: Center(
//                   child: Text('Diff', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14)),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           Container(
//             width: double.infinity,
//             height: 1,
//             color: Color(0xFF828282),
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           HighLevelScoresRow(
//             category: 'Alignment',
//             score: '65.7',
//             ceo: '49',
//             cSuite: '63',
//             staff: '67',
//             diff: '18',
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           HighLevelScoresRow(
//             category: 'Process',
//             score: '70.7',
//             ceo: '49',
//             cSuite: '63',
//             staff: '67',
//             diff: '18',
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           HighLevelScoresRow(
//             category: 'People',
//             score: '45.7',
//             ceo: '49',
//             cSuite: '63',
//             staff: '67',
//             diff: '18',
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           HighLevelScoresRow(
//             category: 'Leadership',
//             score: '56.7',
//             ceo: '23',
//             cSuite: '63',
//             staff: '67',
//             diff: '18',
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           Container(
//             width: double.infinity,
//             height: 1,
//             color: Color(0xFF828282),
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           OverallScoresRow(
//             category: 'Overall',
//             score: '56.7',
//             ceo: '23',
//             cSuite: '63',
//             staff: '67',
//             diff: '18',
//           )
//         ],
//       ),
//     );
//   }
// }
