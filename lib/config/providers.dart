import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/auth/authDisplayNotifier.dart';
import 'package:platform_front/notifiers/auth/authFireStoreServiceNotifier.dart';
import 'package:platform_front/notifiers/auth/emailPasswordValidateNotifier.dart';
import 'package:platform_front/notifiers/auth/selectionButtonNotifier.dart';
import 'package:platform_front/services/httpService.dart';

final authDisplayProvider = StateNotifierProvider<AuthDisplayNotifier, Widget>((ref) {
  return AuthDisplayNotifier();
});

final selectionButtonProvider = StateNotifierProvider<SelectionButtonNotifier, SelectionButtonType>((ref) {
  return SelectionButtonNotifier();
});

final authfirestoreserviceProvider = StateNotifierProvider<AuthFirestoreServiceNotifier, User?>((ref) {
  final auth = AuthFirestoreServiceNotifier();
  auth.initState();
  return auth;
});

final httpServiceProvider = StateNotifierProvider<HttpService, bool>((ref) {
  return HttpService();
});

final emailpasswordvalidateProvider = StateNotifierProvider<EmailpasswordvalidateNotifer, EmailPasswordValidationState>((ref) {
  return EmailpasswordvalidateNotifer();
});