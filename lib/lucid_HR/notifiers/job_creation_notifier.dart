import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/config/enums_hr.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class JobCreationState {
  final EmailListDisplay emailListDisplay;
  final NewJobSearchSection newJobSearchSection;
  final List<String> emailList;
  final Map<Indicator, double> benchmarks;
  final String? jobSearchTitle;
  final String? emailFrom;
  final String? emailSubject;
  final String? emailBody;
  final List<GlobalKey<FormState>> formKeys; //3 form keys for the 3 textfields. for validation

  JobCreationState(
      {required this.emailListDisplay,
      required this.emailList,
      required this.benchmarks,
      required this.jobSearchTitle,
      required this.newJobSearchSection,
      this.emailFrom,
      this.emailSubject,
      this.emailBody,
      required this.formKeys});

  JobCreationState copyWith(
      {EmailListDisplay? emailListDisplay,
      List<String>? emailList,
      Map<Indicator, double>? benchmarks,
      String? jobSearchTitle,
      NewJobSearchSection? newJobSearchSection,
      String? emailFrom,
      String? emailSubject,
      String? emailBody,
      List<GlobalKey<FormState>>? formKeys}) {
    return JobCreationState(
      emailFrom: emailFrom ?? this.emailFrom,
      emailSubject: emailSubject ?? this.emailSubject,
      emailBody: emailBody ?? this.emailBody,
      newJobSearchSection: newJobSearchSection ?? this.newJobSearchSection,
      jobSearchTitle: jobSearchTitle ?? this.jobSearchTitle,
      benchmarks: benchmarks ?? this.benchmarks,
      emailListDisplay: emailListDisplay ?? this.emailListDisplay,
      emailList: emailList ?? this.emailList,
      formKeys: formKeys ?? this.formKeys,
    );
  }

  factory JobCreationState.empty() {
    return JobCreationState(
      newJobSearchSection: NewJobSearchSection.chooseBenchmarks,
      jobSearchTitle: null,
      emailListDisplay: EmailListDisplay.view,
      emailList: [
        "michkwetzel@gmail.com",
        "michskdsd",
      ],
      benchmarks: {
        Indicator.align: 70,
        Indicator.people: 60,
        Indicator.process: 70,
        Indicator.leadership: 50,
      },
      emailBody: """Hi!

You have been invited to an interview with us! 
The details are the following.

Zoom meeting: nfdjnjsdsds
If you wish to stay with us please reply to this email. Weldone with your journey sofar!

Here is the assessment link: [assessment link]

Kind regards,
Test Company""",
      formKeys: [
        GlobalKey<FormState>(),
        GlobalKey<FormState>(),
        GlobalKey<FormState>(),
      ],
    );
  }
}

class JobCreationNotifier extends StateNotifier<JobCreationState> {
  JobCreationNotifier() : super(JobCreationState.empty());

  // Getters

  String? get emailFrom => state.emailFrom;
  String? get emailSubject => state.emailSubject;
  String? get emailBody => state.emailBody;
  List<GlobalKey<FormState>> get formKeys => state.formKeys;

  Map<String, dynamic> getAllData() {
    print('getAllData: ${state.jobSearchTitle}, ${state.emailList}, ${state.benchmarks}, ${state.emailFrom}, ${state.emailSubject}, ${state.emailBody}');

    return {
      'title': state.jobSearchTitle,
      'emailList': state.emailList,
      'benchmarks': state.benchmarks.map((key, value) => MapEntry(key.name, value)),
      'emailFrom': state.emailFrom,
      'subject': state.emailSubject,
      'emailBody': state.emailBody,
    };
  }

  // Benchmarks
  void updateSliderValue(Indicator indicator, double value) {
    state = state.copyWith(benchmarks: {...state.benchmarks, indicator: value});
  }

  void updateJobSearchTitle(String title) {
    state = state.copyWith(jobSearchTitle: title);
  }

  // Email List methods
  void removeEmail(int index) {
    state = state.copyWith(emailList: List.from(state.emailList)..removeAt(index));
  }

  void clearEmails() {
    state = state.copyWith(emailList: []);
  }

  void addEmails(List<String> emailList) {
    state = state.copyWith(emailList: {...state.emailList, ...emailList}.toList());
  }

  void changeToAddEmailsDisplay() {
    state = state.copyWith(emailListDisplay: EmailListDisplay.add);
  }

  void changeToViewEmailsDisplay() {
    state = state.copyWith(emailListDisplay: EmailListDisplay.view);
  }

  // Email Tempalte

  void updateEmailFrom(String emailFrom) {
    state = state.copyWith(emailFrom: emailFrom);
  }

  void updateEmailSubject(String emailSubject) {
    state = state.copyWith(emailSubject: emailSubject);
  }

  void updateEmailBody(String emailBody) {
    state = state.copyWith(emailBody: emailBody);
  }

  // Buttons

  void onNextClicked() {
    state = state.copyWith(newJobSearchSection: NewJobSearchSection.emailTemplate);
  }

  void onBackClicked() {
    state = state.copyWith(newJobSearchSection: NewJobSearchSection.chooseBenchmarks);
  }

  // Textfield Validation

  bool validateAllData() {
    bool flag = true;
    if (state.emailList.isEmpty) {
      state = state.copyWith(emailListDisplay: EmailListDisplay.empty);
      flag = false;
    }
    for (var formKey in state.formKeys) {
      if (!formKey.currentState!.validate()) {
        flag = false;
      }
    }
    return flag;
  }
}
