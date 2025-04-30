import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/create_assessment/emailList/radioButton/radioButtonEmailList.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class RadioButtonRow extends StatelessWidget {
  final AssessmentDisplay display;
  const RadioButtonRow({super.key, this.display = AssessmentDisplay.create});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: RadioButtonEmailList(buttonType: EmailListRadioButtonType.ceo, text: 'CEO', display: display),
        ),
        Flexible(
          child: RadioButtonEmailList(buttonType: EmailListRadioButtonType.cSuite, text: 'C-Suite', display: display),
        ),
        Flexible(
          child: RadioButtonEmailList(buttonType: EmailListRadioButtonType.employee, text: 'Team', display: display),
        ),
      ],
    );
  }
}
