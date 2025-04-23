import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_HR/config/providers_hr.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/job_creation_screen.dart';
import 'package:platform_front/lucid_HR/components/global_components/simple_text_field_gray.dart';

class InputTitleWidget extends ConsumerWidget {
  const InputTitleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: SimpleTextFieldGray(
            formKey: ref.read(jobCreationProvider.notifier).formKeys[0],
            onTextChanged: ref.read(jobCreationProvider.notifier).updateJobSearchTitle,
            hintText: "Please Enter Job Title...",
            validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter a Title";
            }
            return null;
          },
          ),
        )
      ],
    );
  }
}
