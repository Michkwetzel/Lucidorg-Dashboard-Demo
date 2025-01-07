import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/radioButton/radioButtonRow.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListAdd/uploadCSVWidget.dart';
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
  String? errorTextFieldText;
  String? errorCSVText;
  bool errorTextField = false;
  bool errorCSV = false;
  bool displayErrorCSV = false;
  double textFieldHeight = 50;
  final FocusNode _focusNode = FocusNode();
  bool hideWidgets = false;

  void extractEmailsFromTextField() {
    try {
      final inputEmails = inputController.text
          .split(RegExp(r'[,\n\s]+')) // Split by comma, newline, or whitespace
          .where((email) => email.isNotEmpty) // Remove empty entries
          .map((e) => e.trim()) // Trim any remaining whitespace
          .toList();

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
      }
      setState(() {
        errorTextField = false;
        errorTextFieldText = null;
      });
    } catch (e) {
      setState(() {
        errorTextField = true;
        errorTextFieldText = e.toString();
      });
    }
  }

  void onUploadPressed() {
    setState(() {
      displayErrorCSV = false;
    });
    extractEmailsFromTextField();
    List<String> newValidEmails = [...newValidEmailsCSV, ...newValidEmailsTextField].toSet().toList();
    if (!errorCSV && !errorTextField) {
      print(newValidEmails);
      if (newValidEmails.isNotEmpty) {
        ref.read(emailListProvider.notifier).addEmails(newValidEmails, ref.watch(emailListRadioButtonProvider));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(newValidEmails.length == 1
                  ? 'Successfully loaded ${newValidEmails.length} ${ref.read(emailListRadioButtonProvider.notifier).toString()} email'
                  : 'Successfully loaded ${newValidEmails.length} ${ref.read(emailListRadioButtonProvider.notifier).toString()} emails')),
        );
        ref.read(emailListProvider.notifier).changeToViewEmailsDisplay();
      } else {
        setState(() {
          displayErrorCSV = true;
          errorTextField = true;
          errorTextFieldText = '';
        });
      }
    }
  }

  void handleFocus() {
    setState(() {
      hideWidgets = true;
      textFieldHeight = 200;
    });
  }

  void handleUnfocus() {
    setState(() {
      hideWidgets = false;
      textFieldHeight = 50;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        handleFocus();
      } else {
        handleUnfocus();
      }
    });
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
              focusNode: _focusNode,
              error: errorTextField,
              errorText: errorTextFieldText,
              height: textFieldHeight,
              controller: inputController,
              leadingIcon: Icons.email_outlined,
              hintText: 'Emails, comma or space seperated',
            ),
            if (!hideWidgets) ...[
              errorTextField
                  ? const SizedBox(
                      height: 7,
                    )
                  : const SizedBox(
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
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UploadCSVWidget(
                    displayErrorCSV: displayErrorCSV,
                    onDataExtracted: (List<String> emails, bool errorCSV) {
                      setState(() {
                        displayErrorCSV = errorCSV;
                        errorTextField = false;
                      });
                      this.errorCSV = errorCSV;
                      newValidEmailsCSV = emails;
                    },
                  )
                ],
              )
            ],
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Secondarybutton(onPressed: () => ref.read(emailListProvider.notifier).changeToViewEmailsDisplay(), buttonText: "Cancel"),
            CallToActionButton(onPressed: () => onUploadPressed(), buttonText: "Upload")
          ],
        )
      ],
    );
  }
}
