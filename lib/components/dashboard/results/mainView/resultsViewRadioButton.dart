import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class ResultsViewRadioButton extends ConsumerWidget {
  final String buttonText;
  final ResultSection section;

  const ResultsViewRadioButton({super.key, required this.buttonText, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ResultSection selectedSection = ref.watch(resultsSelectedSectionProvider);

    if (selectedSection == section) {
      return CallToActionButton(onPressed: () {}, buttonText: buttonText);
    } else {
      return Secondarybutton(onPressed: () {}, buttonText: buttonText);
    }
  }
}
