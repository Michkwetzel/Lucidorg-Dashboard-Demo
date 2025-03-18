import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/assessment/currentAssessment/currentAssessmentEmailProvider.dart';
import 'package:platform_front/notifiers/assessment/currentAssessment/reminderEmailTemplateProvider.dart';
import 'package:platform_front/notifiers/assessment/toggle_sub_menu_provider.dart';
import 'package:platform_front/notifiers/auth/authLoadState.dart';
import 'package:platform_front/notifiers/auth/emailPasswordProvider.dart';
import 'package:platform_front/notifiers/financials/finance_model_notifer.dart';
import 'package:platform_front/notifiers/impact/impact_display_notifier.dart';
import 'package:platform_front/notifiers/loading/loadingNotifer.dart';
import 'package:platform_front/notifiers/navBar/navBarExpandState.dart';
import 'package:platform_front/notifiers/scoreCompare/score_compare_provider.dart';
import 'package:platform_front/notifiers/selectedDiffMatrix/selected_department_diff_matrix_notifer.dart';
import 'package:platform_front/notifiers/selectedDiffMatrix/selected_diff_matrix.dart';
import 'package:platform_front/notifiers/selectedHomeScreen/selected_home_display_notifer.dart';
import 'package:platform_front/notifiers/selectedIndicator/selected_indicator.dart';
import 'package:platform_front/notifiers/surveyMetrics/survey_metrics_provider.dart';
import 'package:platform_front/notifiers/userResultsData/userResultsData.dart';
import 'package:platform_front/notifiers/Results/resultsDisplayNotifer.dart';
import 'package:platform_front/notifiers/auth/authDisplayNotifier.dart';
import 'package:platform_front/notifiers/auth/authFireStoreServiceNotifier.dart';
import 'package:platform_front/notifiers/auth/authTokenNotifier.dart';
import 'package:platform_front/notifiers/auth/emailPasswordValidateNotifier.dart';
import 'package:platform_front/notifiers/auth/selectionButtonNotifier.dart';
import 'package:platform_front/notifiers/companyInfo/companyInfoNotifer.dart';
import 'package:platform_front/notifiers/assessment/createAssessment/emailListNotifer.dart';
import 'package:platform_front/notifiers/assessment/createAssessment/emailListRadioButtonNotifier.dart';
import 'package:platform_front/notifiers/assessment/createAssessment/emailTemplateNotifer.dart';
import 'package:platform_front/services/companyInfoService.dart';
import 'package:platform_front/notifiers/navBar/navBarNotifer.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';
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
  final UserResultsData activeAssessmentDataNotifier = ref.watch(activeAssessmentDataProvider.notifier);
  final UserProfileDataNotifier userDataNotifier = ref.watch(userDataProvider.notifier);
  final CompanyInfoNotifer companyInfoNotifer = ref.watch(companyInfoProvider.notifier);
  final EmailListNotifier emailListNotifier = ref.watch(emailListProvider.notifier);
  final auth = AuthFirestoreServiceNotifier(
      companyInfoNotifer: companyInfoNotifer,
      emailListNotifier: emailListNotifier,
      firebaseServiceNotifier: firebaseServiceNotifier,
      activeAssessmentDataNotifier: activeAssessmentDataNotifier,
      userDataNotifier: userDataNotifier);
  auth.initState();
  return auth;
});

final emailpasswordvalidateProvider = StateNotifierProvider<EmailpasswordvalidateNotifer, EmailPasswordValidationState>((ref) {
  return EmailpasswordvalidateNotifer();
});

final googlefunctionserviceProvider = StateNotifierProvider<GoogleFunctionService, GoogleFunctionServiceState>((ref) {
  final emailTemplateNotifer = ref.watch(emailTemplateProvider.notifier);
  final emailListNotifier = ref.watch(emailListProvider.notifier);
  final activeAssessmentDataNotifier = ref.watch(activeAssessmentDataProvider.notifier);
  final userDataNotifier = ref.watch(userDataProvider.notifier);
  final reminderEmailTemplateNotifer = ref.watch(reminderEmailTemplateProvider.notifier);

  return GoogleFunctionService(
    reminderEmailTemplateNotifer: reminderEmailTemplateNotifer,
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
  final userDataNotifier = ref.watch(userDataProvider.notifier);
  return EmailListNotifier(userDataNotifier);
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

final activeAssessmentDataProvider = StateNotifierProvider<UserResultsData, UserResultsDataState>((ref) {
  final FirebaseServiceNotifier firebaseServiceNotifier = ref.watch(firebaseServiceNotifierProvider.notifier);
  return UserResultsData(firebaseservicenotifier: firebaseServiceNotifier);
});

final userDataProvider = StateNotifierProvider<UserProfileDataNotifier, UserProfileState>((ref) {
  final activeAssessmentDataNotifier = ref.watch(activeAssessmentDataProvider.notifier);
  return UserProfileDataNotifier(userResultsData: activeAssessmentDataNotifier);
});

final resultsSelectedSectionProvider = StateNotifierProvider<ResultsDisplayNotifier, ResultSection>((ref) {
  return ResultsDisplayNotifier();
});

final companyInfoService = StateNotifierProvider<CompanyInfoService, bool>((ref) {
  final firebaseService = ref.watch(firebaseServiceNotifierProvider.notifier);
  final userDataNotifier = ref.watch(userDataProvider.notifier);
  final companyInfoNotifer = ref.watch(companyInfoProvider.notifier);
  return CompanyInfoService(firebaseService: firebaseService, userProfileDataNotifier: userDataNotifier, companyInfoNotifer: companyInfoNotifer);
});

final navBarExpandStateNotifier = StateNotifierProvider<NavBarExpandStateNotifier, bool>((ref) {
  return NavBarExpandStateNotifier();
});

final impactSelectedSectionProvider = StateNotifierProvider<ImpactDisplayNotifier, ImpactSection>((ref) {
  return ImpactDisplayNotifier();
});

final scoreCompareProvider = StateNotifierProvider<ScoreCompareNotifier, ScoreCompareState>((ref) {
  return ScoreCompareNotifier();
});

final metricsDataProvider = StateNotifierProvider<MetricsDataProvider, MetricsDataState>((ref) {
  final userProfileDataNotifier = ref.watch(userDataProvider.notifier);
  final scoreCompareNotifier = ref.watch(scoreCompareProvider.notifier);
  final currentEmailListNotifier = ref.watch(currentEmailListProvider.notifier);
  return MetricsDataProvider(
    scoreCompareProvider: scoreCompareNotifier,
    userProfileData: userProfileDataNotifier,
    currentAssessmentProvider: currentEmailListNotifier,
  );
});

final loadingProvider = StateNotifierProvider<Loadingnotifier, bool>((ref) {
  return Loadingnotifier();
});

final selectedIndicatorProvider = StateNotifierProvider<SelectedIndicator, Indicator>((ref) {
  return SelectedIndicator();
});

final authloadStateProvider = StateNotifierProvider<AuthLoadState, bool>((ref) {
  return AuthLoadState();
});

final emailPasswordProvider = StateNotifierProvider<EmailPasswordProvider, EmailPasswordState>((ref) {
  return EmailPasswordProvider();
});

final selectedDiffMatrixProvider = StateNotifierProvider<SelectedDiffMatrix, Indicator>((ref) {
  return SelectedDiffMatrix();
});

final selectedDepartmentDiffMatrixNotiferProvider = StateNotifierProvider<SelectedDepartmentDiffMatrixNotifer, Department>((ref) {
  return SelectedDepartmentDiffMatrixNotifer();
});

final selectedHomeDisplayProvider = StateNotifierProvider<SelectedHomeDisplayNotifer, HomeSection>((ref) {
  return SelectedHomeDisplayNotifer();
});

final reminderEmailTemplateProvider = StateNotifierProvider<ReminderEmailTemplateNotifer, ReminderEmailTemplateState>((ref) {
  return ReminderEmailTemplateNotifer();
});

final currentEmailListProvider = StateNotifierProvider<CurrentEmailListNotifier, CurrentEmailListState>((ref) {
  final userProfileDataNotifier = ref.watch(userDataProvider.notifier);
  return CurrentEmailListNotifier(userData: userProfileDataNotifier);
});

final toggleSubMenuProvider = StateNotifierProvider<ToggleSubMenuProvider, bool>((ref) {
  return ToggleSubMenuProvider();
});

final financeModelProvider = StateNotifierProvider<FinanceModelNotifer, FinanceModelState>((ref) {
  final metricsDataNotifer = ref.watch(metricsDataProvider.notifier);
  return FinanceModelNotifer(metricsDataProvider: metricsDataNotifer);
});
