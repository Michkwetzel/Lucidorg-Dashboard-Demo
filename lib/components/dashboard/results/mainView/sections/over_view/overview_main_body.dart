import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class OverviewMainView extends StatelessWidget {
  const OverviewMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Company Trajectory', style: kH3PoppinsRegular),
        //TODO: graph here
        SizedBox(
          height: 400,
          width: 500,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Overview:',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 24),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Your overall efficiency benchmark assessment is 61%, which is slightly above average for companies at your stage of growth, and just 9 points below the 70% threshold for smooth scaling!\n\nYour overall differentiation is at 15% which is average for companies at your current stage of growth\n\nFocussing on areas of high differentiation first is imperative and provides the most impact across the organization',
            style: TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w400, fontSize: 18),
          ),
        )
      ],
    );
  }
}
