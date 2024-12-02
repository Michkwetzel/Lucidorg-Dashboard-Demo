import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/enums.dart';
import 'package:platform_front/notifiers/auth/authDisplayState.dart';
import 'package:platform_front/notifiers/auth/selectionButtonState.dart';

final authDisplayProvider = StateNotifierProvider<AuthDisplayNotifier, Widget>((ref) {
  return AuthDisplayNotifier();
});

final selectionButtonProvider = StateNotifierProvider<SelectionButtonState, SelectionButtonType>((ref) {
  return SelectionButtonState();
});