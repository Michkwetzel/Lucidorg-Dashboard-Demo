import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/auth/buttons/bottomButtonsRow.dart';
import 'package:platform_front/components/auth/layouts/createAccountScreen.dart';
import 'package:platform_front/components/buttons/selectionButton.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/components/auth/layouts/appEntryLayout.dart';
import 'package:platform_front/components/auth/layouts/enterEmailPasswordLayout.dart';
import 'package:platform_front/components/auth/layouts/enterTokenLayout.dart';

class UserTypeSelectionLayout extends ConsumerWidget {
  const UserTypeSelectionLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    void onPressedNextButton() {
      var selectedButton = ref.read(selectionButtonProvider);
      if (selectedButton == SelectionButtonType.none) {
        //TODO: Red Error Text
      } else if (selectedButton == SelectionButtonType.token) {
        ref.read(authDisplayProvider.notifier).changeDisplay(const EnterTokenLayout());
      } else {
        ref.read(authDisplayProvider.notifier).changeDisplay(CreateAccountScreen());
      }
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/logo/tempLogo.png', scale: kLogoScale),
            const SizedBox(height: 12),
            const Text("Please select", style: kH3TextStyle),
            const SizedBox(height: 12),
            screenWidth < 600
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Selectionbutton(buttonText: 'I have a token', buttonType: SelectionButtonType.token),
                      SizedBox(height: 12),
                      Selectionbutton(buttonText: 'I am testing \nthe product', buttonType: SelectionButtonType.guest)
                    ],
                  )
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Selectionbutton(buttonText: 'I have a token', buttonType: SelectionButtonType.token),
                      SizedBox(width: 24),
                      Selectionbutton(buttonText: 'I am testing \nthe product', buttonType: SelectionButtonType.guest)
                    ],
                  ),
            const SizedBox(height: 24),
            BottomButtonsRow(
              width: screenWidth < 600 ? -1 : 320,
              onPressedBackButton: () {
                ref.read(selectionButtonProvider.notifier).onButtonSelect(SelectionButtonType.none);
                ref.read(authDisplayProvider.notifier).changeDisplay(const AppEntryLayout());
              },
              onPressedNextButton: () => onPressedNextButton(),
              nextButtonText: "Continue",
            )
          ],
        ),
      ),
    );
  }
}
