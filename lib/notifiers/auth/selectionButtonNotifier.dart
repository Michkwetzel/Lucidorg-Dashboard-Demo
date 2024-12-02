import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

//State of selection Buttons. Keep track of which button is selected by user.
class SelectionButtonNotifier extends StateNotifier<SelectionButtonType> {
  SelectionButtonNotifier() : super(SelectionButtonType.none);

  void onButtonSelect(SelectionButtonType selectedButton) {
    state = selectedButton;
  }
}
