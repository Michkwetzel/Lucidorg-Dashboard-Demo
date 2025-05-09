import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class FocusDisplayNotifier extends StateNotifier<FocusSection> {
  FocusDisplayNotifier() : super(FocusSection.diffPyramid);

  void setDisplay(FocusSection section) {
    state = section;
  }
}
