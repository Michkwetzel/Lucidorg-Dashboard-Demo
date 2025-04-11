import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/components/company_info/customTextFieldForm.dart';

class InputTitleWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const InputTitleWidget({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Title",
          style: kH2TextStyle,
        ),
        SizedBox(
          width: 350,
          height: 50,
          child: CustomTextFieldForm(
            hintText: "Please Enter Job Title...",
            textEditController: textEditingController,
          ),
        )
      ],
    );
  }
}
