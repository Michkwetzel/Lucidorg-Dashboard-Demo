import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class FormTextField extends ConsumerWidget {
  final String? Function(String?)? validator;
  final String textFieldType;
  final String? forcedErrorText;

  const FormTextField({super.key, required this.validator, required this.textFieldType, this.forcedErrorText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
        forceErrorText: forcedErrorText,
        validator: validator,
        enableInteractiveSelection: true,
        onChanged: (value) {
          if (textFieldType == 'email') {
            ref.read(emailPasswordProvider.notifier).updateEmail(value);
          } else {
            ref.read(emailPasswordProvider.notifier).updatePassword(value);
          }
        },
        maxLines: null,
        style: const TextStyle(
          letterSpacing: 0.4,
          fontSize: 16.0,
          height: 1.5,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: const Color(0xFFF3F3F3),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
        ));
  }
}
