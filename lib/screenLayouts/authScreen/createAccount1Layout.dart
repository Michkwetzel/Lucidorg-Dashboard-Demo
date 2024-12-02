import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/authScreen/bottomButtonsRow.dart';
import 'package:platform_front/components/textFields/textfieldGray.dart';
import 'package:platform_front/constants.dart';
import 'package:platform_front/providers.dart';
import 'package:platform_front/screenLayouts/authScreen/appEntryLayout.dart';
import 'package:platform_front/screenLayouts/authScreen/createAccount2Layout.dart';

class CreateAccount1Layout extends ConsumerWidget {
  const CreateAccount1Layout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(32),
      width: 350,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/logo/tempLogo.png', scale: kLogoScale),
          const SizedBox(height: 12),
          const Text("Email", style: kTextFieldHeaderTextStyle),
          const SizedBox(height: 2),
          const TextfieldGray(),
          const SizedBox(height: 24),
          const Text("Password", style: kTextFieldHeaderTextStyle),
          const SizedBox(height: 2),
          const TextfieldGray(),
          const SizedBox(height: 24),
          BottomButtonsRow(
            onPressedBackButton: () => ref.read(authDisplayProvider.notifier).changeDisplay(AppEntryLayout()),
            onPressedNextButton: () => ref.read(authDisplayProvider.notifier).changeDisplay(CreateAccount2Layout()),
            nextButtonText: "Continue",
          ),
        ],
      ),
    );
  }
}
