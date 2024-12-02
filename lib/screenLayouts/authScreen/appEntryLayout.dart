import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/buttons/secondaryButton.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/screenLayouts/authScreen/createAccount1Layout.dart';

class AppEntryLayout extends ConsumerWidget {
  const AppEntryLayout({super.key});

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
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Secondarybutton(
                onPressed: () => ref.read(authDisplayProvider.notifier).changeDisplay(const CreateAccount1Layout()),
                buttonText: "Create Account",
              ),
              CallToActionButton(
                  onPressed: () => ref.read(authDisplayProvider.notifier).changeDisplay(const CreateAccount1Layout(
                        logIn: true,
                      )),
                  buttonText: "Log in")
            ],
          )
        ],
      ),
    );
  }
}
