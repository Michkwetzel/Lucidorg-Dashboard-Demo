import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/providers.dart';

class TemplateEdit extends ConsumerStatefulWidget {
  TemplateEdit({
    super.key,
  });

  @override
  ConsumerState<TemplateEdit> createState() => _TemplateEditState();
}

class _TemplateEditState extends ConsumerState<TemplateEdit> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: true, // Add this

      enableInteractiveSelection: true,
      scrollPadding: EdgeInsets.zero,
      initialValue: ref.read(emailTemplateProvider.notifier).templateBody,
      onChanged: (value) => ref.read(emailTemplateProvider.notifier).updateTemplateText(value),
      maxLines: null,
      style: const TextStyle(
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
