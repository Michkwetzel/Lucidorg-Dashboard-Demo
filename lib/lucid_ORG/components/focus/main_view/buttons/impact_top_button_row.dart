import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/focus/main_view/buttons/impact_view_radio_button.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class ImpactActionBar extends StatelessWidget {
  const ImpactActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    String heading = 'What to do next?';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: TextStyle(fontFamily: "OpenSans", fontWeight: FontWeight.w600, fontSize: 30, color: Color(0xFF494949)),
        ),
        Row(
          spacing: 32,
          children: [
            ImpactViewRadioButton(buttonText: 'Action Step 1', section: ImpactSection.diffPyramid),
            ImpactViewRadioButton(buttonText: 'Action Step 2', section: ImpactSection.scorePyramid),
          ],
        )
      ],
    );
  }
}
