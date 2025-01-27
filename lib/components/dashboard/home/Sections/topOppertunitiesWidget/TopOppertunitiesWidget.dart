import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/home/Sections/topOppertunitiesWidget/top_oppertunities_row.dart';
import 'package:platform_front/config/constants.dart';

class TopOppertunitiesWidget extends StatelessWidget {
  const TopOppertunitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 611,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: kboxShadowNormal,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Opportunities',
            style: kH2PoppinsRegular,
          ),
          TopOppertunitiesRow(text: "Meeting Efficacy", diff: '~42.3%', score: '23%'),
          TopOppertunitiesRow(text: "Cross-Functional Accountability", diff: '~42.3%', score: '23%'),
          Text(
            'Top Concern',
            style: kH2PoppinsRegular,
          ),
          TopOppertunitiesRow(text: "Cross-Functional Teams", diff: '~42.3%', score: '23%'),
        ],
      ),
    );
  }
}
