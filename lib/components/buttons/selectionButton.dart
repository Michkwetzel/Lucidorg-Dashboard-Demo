import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/constants.dart';
import 'package:platform_front/enums.dart';
import 'package:platform_front/providers.dart';

// Radio Button used for selecting token or guest or viewer of results in auth log in
class Selectionbutton extends ConsumerWidget {
  final String buttonText;
  final SelectionButtonType buttonType;

  const Selectionbutton({super.key, required this.buttonText, required this.buttonType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(selectionButtonProvider) == buttonType;

    return SizedBox(
      height: kSelectionButtonHeight,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        onPressed: () => ref.read(selectionButtonProvider.notifier).onButtonSelect(buttonType),
        color: isSelected ? const Color(0xFFBDF1F7) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: isSelected ? const Color(0xFF0118E5) : const Color(0xFFBBBBBB), width: 1),
        ),
        elevation: 1,
        child: Text(
          buttonText,
          style: kSelectionButtonTexyStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
