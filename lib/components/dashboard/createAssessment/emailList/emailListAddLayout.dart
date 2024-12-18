import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/radioButton/radioButtonRow.dart';
import 'package:platform_front/components/textFields/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class Emaillistaddlayout extends ConsumerWidget {
  Emaillistaddlayout({super.key});

  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Emails',
              style: kH2TextStyle,
            ),
            const SizedBox(height: 12),
            const Text(
              'Select appropriate department',
              style: kInfoTextTextStyle,
            ),
            const SizedBox(height: 12),
            RadioButtonRow(),
            const SizedBox(height: 12),
            TextfieldGray(controller: inputController, height: 100, leadingIcon: Icons.email_outlined, hintText: 'Email list, comma seperated',)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Secondarybutton(onPressed: () => ref.read(emailListProvider.notifier).changeToViewEmailsDisplay(), buttonText: "Cancel"),
            CallToActionButton(onPressed: () {}, buttonText: "Upload")
          ],
        )
      ],
    );
  }
}

class uploadCSVFileWidget extends StatelessWidget {
  const uploadCSVFileWidget({super.key});
  //TODO: create here.
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialButton(
      onPressed: () {},
    ));
  }
}
