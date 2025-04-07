// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextFieldForm extends StatelessWidget {
  const CustomTextFieldForm({
    super.key,
    required this.ref,
    required this.companyNameController,
  });

  final WidgetRef ref;
  final TextEditingController companyNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        //initialValue: ref.read(companyInfoProvider.notifier).companyName ?? "",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter Company Name";
          }
          return null;
        },
        controller: companyNameController,
        decoration: InputDecoration(
          filled: true,
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
