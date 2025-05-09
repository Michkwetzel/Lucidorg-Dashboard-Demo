import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/buttons/secondaryButton.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class FocusActionBarButton extends ConsumerWidget {
  final String buttonText;
  final FocusSection section;

  const FocusActionBarButton({super.key, required this.buttonText, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusSection selectedSection = ref.watch(focusSelectedSectionProvider);

    if (selectedSection == section) {
      return CallToActionButton(onPressed: () {}, buttonText: buttonText);
    } else {
      return Secondarybutton(onPressed: () => ref.read(focusSelectedSectionProvider.notifier).setDisplay(section), buttonText: buttonText);
    }
  }
}
