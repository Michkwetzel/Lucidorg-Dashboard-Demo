import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';

class SimpleTextFieldGray extends ConsumerWidget {
  final Function(String) onTextChanged;
  final String? heading;
  final String? hintText;
  final GlobalKey<FormState>? formKey;
  final String? Function(String?)? validator;

  const SimpleTextFieldGray({super.key, required this.onTextChanged, this.hintText, this.heading, this.formKey, this.validator});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget returnTextfield() {
      return SizedBox(
        width: 250,
        child: Form(
          key: formKey,
          child: TextFormField(
              autovalidateMode: AutovalidateMode.onUnfocus,
              onChanged: onTextChanged,
              validator: validator,
              decoration: InputDecoration(
                filled: true,
                hintText: hintText,
                hintStyle: ktextFieldHintStyle,
                fillColor: const Color(0xFFEFEFEF),
                focusColor: const Color(0xFFEFEFEF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
              )),
        ),
      );
    }

    if (heading != null) {
      return Row(
        children: [
          SizedBox(width: 100, child: Text(heading!, style: ktextFieldHeadingStyle)),
          returnTextfield(),
        ],
      );
    }
    return returnTextfield();
  }
}
