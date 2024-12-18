import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/radioButton/radioButtonRow.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/uploadCSVWidget.dart';
import 'package:platform_front/components/textFields/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class Emaillistaddlayout extends ConsumerStatefulWidget {
  Emaillistaddlayout({super.key});

  @override
  ConsumerState<Emaillistaddlayout> createState() => _EmaillistaddlayoutState();
}

class _EmaillistaddlayoutState extends ConsumerState<Emaillistaddlayout> {
  final TextEditingController inputController = TextEditingController();
  List<String> newValidEmailsTextField = [];
  List<String> newValidEmailsCSV = [];
  String? errorText;
  bool errorTextField = false;
  bool errorCSV = false;

  void extractEmailsFromTextField() {
    try {
      final inputEmails = inputController.text.split(',').map((e) => e.trim()).toList();

      for (int i = 0; i < inputEmails.length; i++) {
        final email = inputEmails[i];

        if (email.isEmpty) continue;

        // Regular expression for email validation
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

        if (!emailRegex.hasMatch(email)) {
          throw 'Invalid email format at position ${i + 1}: $email';
        } else {
          newValidEmailsTextField.add(email);
        }
        if (errorTextField) {
          setState(() {
            errorTextField = false;
            errorText = null;
          });
        }
      }
    } catch (e) {
      setState(() {
        errorTextField = true;
        errorText = e.toString();
      });
    }
  }

  void onUploadPressed() {
    extractEmailsFromTextField();
    List<String> newValidEmails = [...newValidEmailsCSV, ...newValidEmailsTextField].toSet().toList();
    if (!errorCSV && !errorTextField) {
      print(newValidEmails);
      if (newValidEmails.isNotEmpty) {
        ref.read(emailListProvider.notifier).addEmails(newValidEmails, ref.watch(emailListRadioButtonProvider) );
      }
      ref.read(emailListProvider.notifier).changeToViewEmailsDisplay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const RadioButtonRow(),
            const SizedBox(height: 24),
            TextfieldGray(
              error: errorTextField,
              errorText: errorText,
              height: 50,
              controller: inputController,
              leadingIcon: Icons.email_outlined,
              hintText: 'Emails, comma seperated',
            ),
            SizedBox(
              height: 24,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Or',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UploadCSVWidget(
                  onDataExtracted: (List<String> emails, bool errorCSV) {
                    this.errorCSV = errorCSV;
                    newValidEmailsCSV = emails;
                  },
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Secondarybutton(onPressed: () => ref.read(emailListProvider.notifier).changeToViewEmailsDisplay(), buttonText: "Cancel"),
            CallToActionButton(onPressed: () =>  onUploadPressed(), buttonText: "Upload")
          ],
        )
      ],
    );
  }
}
