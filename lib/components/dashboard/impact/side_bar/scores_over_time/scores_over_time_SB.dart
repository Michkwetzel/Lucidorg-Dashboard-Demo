import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class ScoresOverTimeSB extends StatelessWidget {
  const ScoresOverTimeSB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25).copyWith(top: 40),
      child: Column(
        spacing: 16,
        children: [
          Text('Scores Over Time', style: kH2PoppinsLight),
          SizedBox(height: 16),
          Text('Top 3 Areas', style: kH2PoppinsRegular),
          SizedBox(height: 8),
          ScoresOverTimeRow(heading: 'Meeting Efficacy', score: 65.7, diff: 23.5),
          ScoresOverTimeRow(heading: 'X-Functional Comms', score: 65.7, diff: 23.5),
          ScoresOverTimeRow(heading: 'Collaborative KPI\'s', score: 65.7, diff: 23.5),
          SizedBox(height: 16),
          Text('Top 3 Areas', style: kH2PoppinsRegular),
          SizedBox(height: 8),
          ScoresOverTimeRow(heading: 'Meeting Efficacy', score: 65.7, diff: 23.5),
          ScoresOverTimeRow(heading: 'X-Functional Comms', score: 65.7, diff: 23.5),
          ScoresOverTimeRow(heading: 'Collaborative KPI\'s', score: 65.7, diff: 23.5),
        ],
      ),
    );
  }
}

class ScoresOverTimeRow extends StatelessWidget {
  final String heading;
  final double score;
  final double diff;
  const ScoresOverTimeRow({super.key, required this.heading, required this.score, required this.diff});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            heading,
            style: kH5PoppinsLight,
          ),
        ),
        Container(
          width: 60,
          height: 50,
          decoration: kGrayBox,
          child: Center(child: Text('$score%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
        ),
        Container(
          width: 60,
          height: 50,
          decoration: kDiffRedBox,
          child: Center(child: Text('~$diff%', style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w300))),
        ),
      ],
    );
  }
}
