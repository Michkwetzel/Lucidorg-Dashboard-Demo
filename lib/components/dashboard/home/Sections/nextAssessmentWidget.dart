import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class NextAssessmentWidget extends StatelessWidget {
  final String nextAssessmentData;

  const NextAssessmentWidget({
    required this.nextAssessmentData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(12)),
        child: Text(
          'Next Assessment: $nextAssessmentData',
          style: kH5PoppinsRegular,
        ),
      ),
    );
  }
}
