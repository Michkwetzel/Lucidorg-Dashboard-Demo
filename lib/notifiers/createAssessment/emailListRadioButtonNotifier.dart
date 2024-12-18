import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class EmailListRadioButtonNotifier extends StateNotifier<EmailListRadioButtonType> {
  EmailListRadioButtonNotifier() : super(EmailListRadioButtonType.ceo);

  void onButtonSelect(EmailListRadioButtonType selectedButton) {
    state = selectedButton;
  }
}
