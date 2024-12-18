import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/radioButton/radioButtonEmailList.dart';
import 'package:platform_front/config/enums.dart';

class RadioButtonRow extends StatelessWidget {
  const RadioButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Flexible(
          child: RadioButtonEmailList(buttonType: EmailListRadioButtonType.ceo, text: 'CEO'),
        ),
        Flexible(
          child: RadioButtonEmailList(buttonType: EmailListRadioButtonType.cSuite, text: 'C-Suite'),
        ),
        Flexible(
          child: RadioButtonEmailList(buttonType: EmailListRadioButtonType.employee, text: 'Employee'),
        ),
      ],
    );
  }
}
