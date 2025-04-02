import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class ReminderSubjectEdit extends ConsumerWidget {
  final String? Function(String?)? validator;

  const ReminderSubjectEdit({
    super.key,
    required this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      enableInteractiveSelection: true,
      initialValue: ref.read(reminderEmailTemplateProvider.notifier).subject,
      onChanged: (value) => ref.read(reminderEmailTemplateProvider.notifier).updateSubjectText(value),
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
