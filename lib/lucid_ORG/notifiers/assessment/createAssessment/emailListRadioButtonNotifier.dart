import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class EmailListRadioButtonNotifier extends StateNotifier<EmailListRadioButtonType> {
  EmailListRadioButtonNotifier() : super(EmailListRadioButtonType.ceo);

  void onButtonSelect(EmailListRadioButtonType selectedButton) {
    state = selectedButton;
  }

  @override
  String toString() {
    switch (state) {
      case (EmailListRadioButtonType.ceo):
        return "Ceo";
      case (EmailListRadioButtonType.employee):
        return "Employee";
      case (EmailListRadioButtonType.cSuite):
        return "C-Suite";
    }
  }
}
