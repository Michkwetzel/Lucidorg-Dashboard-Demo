import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/providers.dart';

class TemplateEdit extends ConsumerWidget {
  final String? Function(String?)? validator;
  TemplateEdit({
    Key? key,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      enableInteractiveSelection: true,
      initialValue: ref.read(emailTemplateProvider.notifier).templateBody,
      onChanged: (value) => ref.read(emailTemplateProvider.notifier).updateTemplateText(value),
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
        contentPadding: EdgeInsets.all(6),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}
