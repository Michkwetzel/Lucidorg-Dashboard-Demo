import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/ActiveAssessmentData/ActiveAssessmentDataNotifier.dart';
import 'package:platform_front/notifiers/Results/resultsDisplayNotifer.dart';
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
import 'package:platform_front/notifiers/userData/userData.dart';
import 'package:platform_front/services/firebaseServiceNotifier.dart';
import 'package:platform_front/services/googleFunctionService.dart';

final authDisplayProvider = StateNotifierProvider<AuthDisplayNotifier, Widget>((ref) {
  return AuthDisplayNotifier();
});

final selectionButtonProvider = StateNotifierProvider<SelectionButtonNotifier, SelectionButtonType>((ref) {
  return SelectionButtonNotifier();
});

final authfirestoreserviceProvider = StateNotifierProvider<AuthFirestoreServiceNotifier, User?>((ref) {
  final FirebaseServiceNotifier firebaseServiceNotifier = ref.watch(firebaseServiceNotifierProvider.notifier);
  final ActiveAssessmentDataNotifier activeAssessmentDataNotifier = ref.watch(activeAssessmentDataProvider.notifier);
  final UserDataNotifier userDataNotifier = ref.watch(userDataProvider.notifier);
  final auth = AuthFirestoreServiceNotifier(firebaseServiceNotifier: firebaseServiceNotifier, activeAssessmentDataNotifier: activeAssessmentDataNotifier, userDataNotifier: userDataNotifier);
  auth.initState();
  return auth;
});

final emailpasswordvalidateProvider = StateNotifierProvider<EmailpasswordvalidateNotifer, EmailPasswordValidationState>((ref) {
  return EmailpasswordvalidateNotifer();
});

final googlefunctionserviceProvider = StateNotifierProvider<GoogleFunctionService, bool>((ref) {
  final emailTemplateNotifer = ref.watch(emailTemplateProvider.notifier);
  final emailListNotifier = ref.watch(emailListProvider.notifier);
  final activeAssessmentDataNotifier = ref.watch(activeAssessmentDataProvider.notifier);
  final userDataNotifier = ref.watch(userDataProvider.notifier);

  return GoogleFunctionService(
    emailListNotifier: emailListNotifier,
    emailTemplateNotifier: emailTemplateNotifer,
    userDataNotifier: userDataNotifier,
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
  return CompanyInfoNotifer(googlefunctionserviceProvider: ref.watch(googlefunctionserviceProvider.notifier));
});

final firebaseServiceNotifierProvider = StateNotifierProvider<FirebaseServiceNotifier, bool>((ref) {
  return FirebaseServiceNotifier();
});

final activeAssessmentDataProvider = StateNotifierProvider<ActiveAssessmentDataNotifier, ActiveAssessmentState>((ref) {
  final FirebaseServiceNotifier firebaseServiceNotifier = ref.watch(firebaseServiceNotifierProvider.notifier);
  return ActiveAssessmentDataNotifier(firebaseservicenotifier: firebaseServiceNotifier);
});

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserState>((ref) {
  final activeAssessmentDataNotifier = ref.watch(activeAssessmentDataProvider.notifier);
  return UserDataNotifier(activeAssessmentDataNotifier: activeAssessmentDataNotifier);
});

final resultsDisplayProvider = StateNotifierProvider<ResultsSideDisplaynotifer, Widget>((ref) {
  return ResultsSideDisplaynotifer();
});
