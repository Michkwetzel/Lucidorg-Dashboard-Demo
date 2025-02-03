import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/scores_over_time/scores_over_time_SB.dart';
import 'package:platform_front/config/constants.dart';

class DiffOverTimeSb extends StatelessWidget {
  const DiffOverTimeSb({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25).copyWith(top: 40),
      child: Column(
        spacing: 16,
        children: [
          Text(
            'Differentiation\nOver Time',
            style: kH2PoppinsLight,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          SideAreasWidget(
            heading: 'Improvement',
          ),
          SizedBox(height: 16),
          SideAreasWidget(
            heading: 'Decline',
          ),
        ],
      ),
    );
  }
}
