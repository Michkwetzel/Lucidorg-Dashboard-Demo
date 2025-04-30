import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/impact/main_view/buttons/impact_view_radio_button.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class ImpactTopButtonRow extends StatelessWidget {
  const ImpactTopButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 32),
        ImpactViewRadioButton(buttonText: 'Org Impact', section: ImpactSection.pyramid1),
        ImpactViewRadioButton(buttonText: 'Financial', section: ImpactSection.financial),
        ImpactViewRadioButton(buttonText: 'Score over time', section: ImpactSection.scoreOverTime),
        ImpactViewRadioButton(buttonText: 'Diff over time', section: ImpactSection.diffOverTime),
      ],
    );
  }
}
