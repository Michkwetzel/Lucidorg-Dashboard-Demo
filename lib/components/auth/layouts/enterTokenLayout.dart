import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/auth/buttons/bottomButtonsRow.dart';
import 'package:platform_front/components/auth/layouts/createAccountScreen.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/components/global/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/components/auth/layouts/enterEmailPasswordLayout.dart';
import 'package:platform_front/components/auth/layouts/userTypeSelectionLayout.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class EnterTokenLayout extends ConsumerStatefulWidget {
  const EnterTokenLayout({super.key});

  @override
  ConsumerState<EnterTokenLayout> createState() => _EnterTokenLayoutState();
}

class _EnterTokenLayoutState extends ConsumerState<EnterTokenLayout> {
  final TextEditingController controller = TextEditingController();
  final Logger logger = Logger("EnterTokenLayout");
  Future<void>? _pendingCheckToken;
  String token = '';

  bool error = false;
  String errorText = '';

  bool success = false;

  @override
  Widget build(BuildContext context) {
    void onPressedNextButton() {
      if (token == '') {
        setState(() {
          error = true;
          errorText = "Please enter a token.";
        });
        return;
      }

      Future<dynamic> pendingCheckToken = ref.read(googlefunctionserviceProvider.notifier).verifyAuthToken(authToken: token);

      setState(() {
        _pendingCheckToken = pendingCheckToken; //Set Loading animation
      });

      // When complete. Either show error or move on
      pendingCheckToken.then((request) async {
        bool? tokenExists = request['tokenExists'];
        bool? tokenUsed = request['tokenUsed'];

        // Show Success bottom sheet, wait 2 seconds. Then move to next screen
        if (tokenExists == true && tokenUsed == false) {
          ref.read(authTokenProvider.notifier).setToken(token);
          SnackBarService.showMessage("Token Verified", Colors.green);
          await Future.delayed(const Duration(seconds: 1));
          logger.info("Token Valid. Change to Next Screen");
          ref.read(authDisplayProvider.notifier).changeDisplay(const CreateAccountScreen());
        }
        // Token has already been used
        else if (tokenExists == true && tokenUsed == true) {
          setState(() {
            error = true;
            errorText = "Token has already been used.";
          });
        }
        // Invalid token
        else {
          setState(() {
            error = true;
            errorText = "Invalid Token";
          });
        }
      }).catchError((e) {
        logger.warning("Checking token Valid failed. Error: $e");
        setState(() {
          error = true;
          errorText = "An error occurred:";
        });
      });
    }

    return FutureBuilder(
        future: _pendingCheckToken,
        builder: (context, snapshot) {
          return OverlayWidget(
            loadingProvider: snapshot.connectionState == ConnectionState.waiting,
            child: Center(
              child: Container(
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
                    TextfieldGray(
                      height: 50,
                      onTextChanged: (value) {
                        token = value;
                      },
                      error: error,
                      errorText: errorText,
                      onSubmitted: () => onPressedNextButton(),
                      controller: controller,
                    ),
                    const SizedBox(height: 24),
                    BottomButtonsRow(
                      onPressedBackButton: () => ref.read(authDisplayProvider.notifier).changeDisplay(const UserTypeSelectionLayout()),
                      onPressedNextButton: () {
                        snapshot.connectionState != ConnectionState.waiting || snapshot.connectionState == ConnectionState.none ? onPressedNextButton() : null;
                      },
                      nextButtonText: "Continue",
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
