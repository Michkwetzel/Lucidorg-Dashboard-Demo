import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/authScreen/bottomButtonsRow.dart';
import 'package:platform_front/components/textFields/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/screenLayouts/authScreen/createAccount2Layout.dart';

class CreateAccount3Layout extends ConsumerWidget {
  const CreateAccount3Layout({super.key});

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
          const Text("Token", style: kTextFieldHeaderTextStyle),
          const SizedBox(height: 2),
          //const TextfieldGray(onTextChanged: (value) {}),
          const SizedBox(height: 24),
          BottomButtonsRow(
            onPressedBackButton: () => ref.read(authDisplayProvider.notifier).changeDisplay(CreateAccount2Layout()),
            onPressedNextButton: () {},
            nextButtonText: "Continue",
          ),
        ],
      ),
    );
  }
}
