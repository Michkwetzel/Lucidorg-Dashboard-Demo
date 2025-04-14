import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_HR/config/providers.dart';
import 'package:platform_front/lucid_HR/createJobSearch/job_creation_screen.dart';

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
          height: 50,
          child: SimpleTextFieldGray(
            onTextChanged: ref.read(jobCreationProvider.notifier).updateJobSearchTitle,
            hintText: "Please Enter Job Title...",
          ),
        )
      ],
    );
  }
}
