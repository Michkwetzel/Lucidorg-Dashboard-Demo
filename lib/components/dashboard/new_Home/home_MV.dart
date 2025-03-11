import 'package:flutter/widgets.dart';
import 'package:platform_front/components/dashboard/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/nextAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/topOppertunitiesWidget/TopOppertunitiesWidget.dart';

class HomeMV extends StatelessWidget {
  const HomeMV({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopOppertunitiesWidget(),
        CurrentActionAreaWidget(),
        NextAssessmentWidget(),
      ],
    );
  }
}
