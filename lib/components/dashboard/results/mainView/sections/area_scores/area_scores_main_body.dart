import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/area_scores/area_score_box.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/area_scores/area_score_diff_box.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/area_scores/department_scores_widget.dart';
import 'package:platform_front/components/dashboard/results/mainView/sections/area_scores/department_text_widget.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/config/constants.dart';

class AreaScoresMainView extends StatelessWidget {
  const AreaScoresMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Meeting Efficacy',
              style: kH3PoppinsMedium,
            ),
          ),
        ),
        SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: GrayDivider(),
        ),
        SizedBox(height: 32),
        DepartmentTextWidget(),
        SizedBox(height: 8),
        DepartmentScoresWidget(ceo: 49, cSuite: 63, staff: 67),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 80,
          children: [
            AreaScoreBox(
              text: 'Overall Score',
              score: 55.7,
            ),
            AreaScoreDiffBox(text: 'Differentiation', diff: 38)
          ],
        ),
        SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 32),
            Expanded(child: Text('3 Month Goal:', style: kH4PoppinsLight)),
            Expanded(child: Text('Questions:', style: kH4PoppinsLight)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 32),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 40),
                child: Text(
                  'Purpose driven culture where the purpose becomes apart of both the internal and eternal stakeholders during the onboarding process\n\nPurpose driven culture where the purpose becomes apart of both the internal and eternal stakeholders during the onboarding process',
                  style: kH7PoppinsLight,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 40),
                child: Text(
                  'Purpose driven culture where the purpose becomes apart of both the internal and eternal stakeholders during the onboarding process\n\nPurpose driven culture where the purpose becomes apart of both the internal and eternal stakeholders during the onboarding process',
                  style: kH7PoppinsLight,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 32),
            Expanded(child: Text('Impact: 1', style: kH4PoppinsLight)),
            Expanded(child: Text('Time: 2', style: kH4PoppinsLight)),
          ],
        )
      ],
    );
  }
}
