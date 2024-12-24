import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/auth/buttons/CustomBackButton.dart';

// Row containing back button and next button. Customizable.
class BottomButtonsRow extends ConsumerWidget {
  final VoidCallback onPressedBackButton;
  final VoidCallback onPressedNextButton;
  final String nextButtonText;
  final double width;
  final bool success;

  const BottomButtonsRow( {this.width = -1, required this.onPressedBackButton, required this.onPressedNextButton, required this.nextButtonText, this.success = false, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (width == -1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Custombackbutton(onPressed: onPressedBackButton),
          const SizedBox(width: 16),
          CallToActionButton(onPressed: onPressedNextButton, buttonText: nextButtonText),
        ],
      );
    }
    return SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Custombackbutton(onPressed: onPressedBackButton),
            const SizedBox(width: 16),
            CallToActionButton(onPressed: onPressedNextButton, buttonText: nextButtonText, isSuccess: success,),
          ],
        ));
  }
}
