import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/enums.dart';

//State of selection Buttons. Keep track of which button is selected by user.
class SelectionButtonState extends StateNotifier<SelectionButtonType> {
  SelectionButtonState() : super(SelectionButtonType.none);

  void onButtonSelect(SelectionButtonType selectedButton) {
    state = selectedButton;
  }
}
