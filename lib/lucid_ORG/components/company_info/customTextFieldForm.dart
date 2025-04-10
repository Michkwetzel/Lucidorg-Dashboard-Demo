// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';

class CustomTextFieldForm extends StatelessWidget {
  const CustomTextFieldForm({
    super.key,
    this.errorText,
    this.hintText,
    required this.textEditController,
  });

  final TextEditingController textEditController;
  final String? errorText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
        controller: textEditController,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: ktextFieldHintStyle,
          fillColor: const Color(0xFFEFEFEF),
          focusColor: const Color(0xFFEFEFEF),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
        ));
  }
}
