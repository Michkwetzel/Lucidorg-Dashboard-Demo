import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/radioButton/radioButtonEmailList.dart';
import 'package:platform_front/config/enums.dart';

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
          child: RadioButtonEmailList(buttonType: EmailListRadioButtonType.employee, text: 'Employee', display: display),
        ),
      ],
    );
  }
}
