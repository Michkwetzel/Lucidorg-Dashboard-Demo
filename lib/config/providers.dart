import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/ActiveAssessmentData/ActiveAssessmentDataNotifier.dart';
import 'package:platform_front/notifiers/auth/authDisplayNotifier.dart';
import 'package:platform_front/notifiers/auth/authFireStoreServiceNotifier.dart';
import 'package:platform_front/notifiers/auth/authTokenNotifier.dart';
import 'package:platform_front/notifiers/auth/emailPasswordValidateNotifier.dart';
import 'package:platform_front/notifiers/auth/selectionButtonNotifier.dart';
import 'package:platform_front/notifiers/companyInfo/companyInfoNotifer.dart';
import 'package:platform_front/notifiers/createAssessment/emailListNotifer.dart';
import 'package:platform_front/notifiers/createAssessment/emailListRadioButtonNotifier.dart';
import 'package:platform_front/notifiers/createAssessment/emailTemplateNotifer.dart';
import 'package:platform_front/notifiers/navBar/navBarNotifer.dart';
import 'package:platform_front/services/firebaseServiceNotifier.dart';
import 'package:platform_front/services/googleFunctionService.dart';

final authDisplayProvider = StateNotifierProvider<AuthDisplayNotifier, Widget>((ref) {
  return AuthDisplayNotifier();
});

final selectionButtonProvider = StateNotifierProvider<SelectionButtonNotifier, SelectionButtonType>((ref) {
  return SelectionButtonNotifier();
});

final authfirestoreserviceProvider = StateNotifierProvider<AuthFirestoreServiceNotifier, UserState>((ref) {
  final FirebaseServiceNotifier firebaseServiceNotifier = ref.watch(firebaseServiceNotifierProvider.notifier);
  final ActiveAssessmentDataNotifier activeAssessmentDataNotifier = ref.watch(activeAssessmentDataProvider.notifier);
  final auth = AuthFirestoreServiceNotifier(firebaseServiceNotifier: firebaseServiceNotifier, activeAssessmentDataNotifier: activeAssessmentDataNotifier);
  auth.initState();
  return auth;
});

final emailpasswordvalidateProvider = StateNotifierProvider<EmailpasswordvalidateNotifer, EmailPasswordValidationState>((ref) {
  return EmailpasswordvalidateNotifer();
});

final googlefunctionserviceProvider = StateNotifierProvider<GoogleFunctionService, bool>((ref) {
  final authNotifier = ref.watch(authfirestoreserviceProvider.notifier);
  final companyInfoNotifer = ref.watch(companyInfoProvider.notifier);
  final emailTemplateNotifer = ref.watch(emailTemplateProvider.notifier);
  final emailListNotifier = ref.watch(emailListProvider.notifier);
  final activeAssessmentDataNotifier = ref.watch(activeAssessmentDataProvider.notifier);

  return GoogleFunctionService(
    emailListNotifier: emailListNotifier,
    emailTemplateNotifier: emailTemplateNotifer,
    companyInfoNotifier: companyInfoNotifer,
    authFirestoreServiceNotifier: authNotifier,
    activeAssessmentDataNotifier: activeAssessmentDataNotifier,
  );
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

final emailTemplateProvider = StateNotifierProvider<EmailTemplateNotifer, EmailTemplateState>((ref) {
  return EmailTemplateNotifer();
});

final companyInfoProvider = StateNotifierProvider<CompanyInfoNotifer, Map<String, String>>((ref) {
  return CompanyInfoNotifer();
});

final firebaseServiceNotifierProvider = StateNotifierProvider<FirebaseServiceNotifier, bool>((ref) {
  return FirebaseServiceNotifier();
});

final activeAssessmentDataProvider = StateNotifierProvider<ActiveAssessmentDataNotifier, ActiveAssessmentState>((ref) {
  final FirebaseServiceNotifier firebaseServiceNotifier = ref.watch(firebaseServiceNotifierProvider.notifier);
  return ActiveAssessmentDataNotifier(firebaseservicenotifier: firebaseServiceNotifier);
});
