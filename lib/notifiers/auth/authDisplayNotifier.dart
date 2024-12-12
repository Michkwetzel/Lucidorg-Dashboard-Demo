import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/screenLayouts/authScreen/appEntryLayout.dart';

// Holds current widget being displayd to user in Auth Process.
class AuthDisplayNotifier extends StateNotifier<Widget> {
  AuthDisplayNotifier() : super(AppEntryLayout());

  void changeDisplay(Widget newDisplay) {
    state = newDisplay;
  }
}
