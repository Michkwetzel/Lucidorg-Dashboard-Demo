import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/authScreen/bottomButtonsRow.dart';
import 'package:platform_front/components/textFields/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/screenLayouts/authScreen/enterEmailPasswordLayout.dart';
import 'package:platform_front/screenLayouts/authScreen/userTypeSelectionLayout.dart';

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

  void _showStandardBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 2), () {
          try {
            if (Navigator.of(context).mounted && Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          } catch (e) {
            logger.info('Bottom Sheet closed before timere: $e');
          }
        });
        return Container(
          decoration: const BoxDecoration(color: Color(0xFFBDF1F7), shape: BoxShape.rectangle, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          height: 100,
          width: 350,
          padding: const EdgeInsets.all(16),
          child: const Center(
            child: Text(
              'Token is Valid',
              style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Open Sans"),
            ),
          ),
        );
      },
    );
  }

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

      Future<dynamic> pendingCheckToken = ref.read(httpServiceProvider.notifier).postRequest(path: 'verifyAuthToken', request: {'token': token});

      setState(() {
        _pendingCheckToken = pendingCheckToken; //Set Loading animation
      });

      // When complete. Either show error or move on
      pendingCheckToken.then((request) async {
        bool? tokenExists = request['tokenExists'];
        bool? tokenUsed = request['tokenUsed'];

        // Show Success bottom sheet, wait 2 seconds. Then move to next screen
        if (tokenExists == true && tokenUsed == false) {
          _showStandardBottomSheet(context);
          await Future.delayed(const Duration(seconds: 2));
          logger.info("Token Valid. Change to Next Screen");
          ref.read(authDisplayProvider.notifier).changeDisplay(EnterEmailPasswordLayout());
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
        logger.warning("Checking token Valid failed.Error: $e");
        setState(() {
          error = true;
          errorText = "An error occurred:";
        });
      });
    }

    return Container(
      padding: const EdgeInsets.all(32),
      width: 350,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 4)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: FutureBuilder(
          future: _pendingCheckToken,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo/tempLogo.png', scale: kLogoScale),
                const SizedBox(height: 12),
                const Text("Token", style: kTextFieldHeaderTextStyle),
                const SizedBox(height: 2),
                TextfieldGray(
                  onTextChanged: (value) {
                    token = value;
                  },
                  isLoading: snapshot.connectionState == ConnectionState.waiting,
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
            );
          }),
    );
  }
}
