import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/auth/authDisplayNotifier.dart';
import 'package:platform_front/notifiers/auth/authFireStoreServiceNotifier.dart';
import 'package:platform_front/notifiers/auth/authTokenNotifier.dart';
import 'package:platform_front/notifiers/auth/emailPasswordValidateNotifier.dart';
import 'package:platform_front/notifiers/auth/selectionButtonNotifier.dart';
import 'package:platform_front/notifiers/createAssessment/emailListNotifer.dart';
import 'package:platform_front/notifiers/createAssessment/emailListRadioButtonNotifier.dart';
import 'package:platform_front/notifiers/navBar/navBarNotifer.dart';
import 'package:platform_front/services/googleFunctionService.dart';

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

final emailpasswordvalidateProvider = StateNotifierProvider<EmailpasswordvalidateNotifer, EmailPasswordValidationState>((ref) {
  return EmailpasswordvalidateNotifer();
});

final googlefunctionserviceProvider = StateNotifierProvider<Googlefunctionservice, bool>((ref) {
  return Googlefunctionservice();
});

final authTokenProvider = StateNotifierProvider<Authtokennotifier, String>((ref) {
  return Authtokennotifier();
});

final emailListRadioButtonProvider = StateNotifierProvider<EmailListRadioButtonNotifier, EmailListRadioButtonType>((ref) {
  return EmailListRadioButtonNotifier();
});

final emailListProvider = StateNotifierProvider<EmailListNotifier, EmailListState>((ref) {
  return EmailListNotifier();
});

final navBarProvider = StateNotifierProvider<Navbarnotifer, NavBarButtonType>((ref) {
  return Navbarnotifer();
});
