import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/dashboard/results/mainView/components/resultsViewRadioButton.dart';
import 'package:platform_front/components/global/buttons/CallToActionButton.dart';
import 'package:platform_front/components/global/buttons/secondaryButton.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class HomeTopButtonRow extends StatelessWidget {
  const HomeTopButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 32),
        HomeViewRadioButton(buttonText: 'Home', section: HomeSection.home),
        HomeViewRadioButton(buttonText: 'Current Assessment', section: HomeSection.home),
        HomeViewRadioButton(buttonText: 'New Assessment', section: HomeSection.home),
        HomeViewRadioButton(buttonText: 'How To', section: HomeSection.home),
      ],
    );
  }
}

class HomeViewRadioButton extends ConsumerWidget {
  final String buttonText;
  final HomeSection section;

  const HomeViewRadioButton({super.key, required this.buttonText, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeSection selectedSection = ref.watch(selectedHomeDisplayProvider);

    if (selectedSection == section) {
      return CallToActionButton(onPressed: () {}, buttonText: buttonText);
    } else {
      return Secondarybutton(onPressed: () => ref.read(selectedHomeDisplayProvider.notifier).changeDisplay(section), buttonText: buttonText);
    }
  }
}
