import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/global/buttons/CallToActionButton.dart';
import 'package:platform_front/components/global/buttons/secondaryButton.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class ImpactViewRadioButton extends ConsumerWidget {
  final String buttonText;
  final ImpactSection section;

  const ImpactViewRadioButton({super.key, required this.buttonText, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ImpactSection selectedSection = ref.watch(impactSelectedSectionProvider);

    if (selectedSection == section) {
      return CallToActionButton(onPressed: () {}, buttonText: buttonText);
    } else {
      return Secondarybutton(onPressed: () => ref.read(impactSelectedSectionProvider.notifier).setDisplay(section), buttonText: buttonText);
    }
  }
}
