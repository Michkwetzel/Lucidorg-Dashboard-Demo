import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/config/providers_hr.dart';

class BodyEmailTemplateEdit extends ConsumerWidget {
  final String? Function(String?)? validator;
  final String initialValue;
  final Function(String) onChanged;

  const BodyEmailTemplateEdit({
    super.key,
    required this.validator,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      enableInteractiveSelection: true,
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: null,
      style: const TextStyle(
        letterSpacing: 0.4,
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(6),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}