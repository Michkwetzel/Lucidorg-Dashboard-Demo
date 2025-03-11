import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';

class CurrentEmailListState {
  final List<String> emailsCeo;
  final List<String> emailsCSuite;
  final List<String> emailsEmployee;
  final bool addEmailDisplay;

  CurrentEmailListState({this.emailsCeo = const [], this.emailsCSuite = const [], this.emailsEmployee = const [], this.addEmailDisplay = false});

  // CopyWith function to create a new instance with optional parameter changes
  CurrentEmailListState copyWith({
    List<String>? emailsCeo,
    List<String>? emailsCSuite,
    List<String>? emailsEmployee,
    bool? addEmailDisplay,
  }) {
    return CurrentEmailListState(
      emailsCeo: emailsCeo ?? this.emailsCeo,
      emailsCSuite: emailsCSuite ?? this.emailsCSuite,
      emailsEmployee: emailsEmployee ?? this.emailsEmployee,
      addEmailDisplay: addEmailDisplay ?? this.addEmailDisplay,
    );
  }
}

class CurrentEmailListNotifier extends StateNotifier<CurrentEmailListState> {
  UserProfileDataNotifier userData;
  CurrentEmailListNotifier({required this.userData})
      : super(CurrentEmailListState(
          emailsCeo: [],
          emailsCSuite: [],
          emailsEmployee: [],
        ));

  Future<void> getCurrentEmails() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    String companyUID = userData.companyUID!;
    String currentAssessment = userData.latestSurveyDocName!;

    final collectionRef = firestore.collection('surveyData/$companyUID/$currentAssessment');

    List<String> ceoEmails = [];
    List<String> cSuiteEmails = [];
    List<String> employeeEmails = [];

    final collectionSnapshot = await collectionRef.get();
    for (var doc in collectionSnapshot.docs) {
      String emailType = doc.data()['emailType']!;
      if (emailType == 'employee') {
        employeeEmails.add(doc.data()['email']!);
      } else if (emailType == 'cSuite') {
        cSuiteEmails.add(doc.data()['email']!);
      } else {
        ceoEmails.add(doc.data()['email']!);
      }
    }
    state = state.copyWith(
      emailsCSuite: cSuiteEmails,
      emailsEmployee: employeeEmails,
      emailsCeo: ceoEmails,
    );
    
  }

  bool get emailsEmpty => state.emailsCSuite.isEmpty && state.emailsCeo.isEmpty && state.emailsEmployee.isEmpty;

  bool get moreThan5Emails => state.emailsCSuite.length + state.emailsCeo.length + state.emailsEmployee.length > 5;

  Future<void> loadEmails() async {}

  Future<void> removeEmail(String emailId) async {}

  void deleteSingleEmail({required int index, required EmailListRadioButtonType type}) {
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        state = state.copyWith(emailsCSuite: List.from(state.emailsCSuite)..removeAt(index));
        break;
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: List.from(state.emailsCeo)..removeAt(index));
        break;
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: List.from(state.emailsEmployee)..removeAt(index));
        break;
    }
  }

  int listLength(EmailListRadioButtonType type) {
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        return state.emailsCSuite.length;
      case EmailListRadioButtonType.ceo:
        return state.emailsCeo.length;
      case EmailListRadioButtonType.employee:
        return state.emailsEmployee.length;
    }
  }

  void deleteAllEmails() {
    state = state.copyWith(emailsCSuite: [], emailsCeo: [], emailsEmployee: []);
  }

  void deleteGroupEmails(EmailListRadioButtonType type) {
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        state = state.copyWith(emailsCSuite: []);
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: []);
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: []);
    }
  }

  void changeToAddEmailsDisplay() {
    state = state.copyWith(addEmailDisplay: true);
  }

  void changeToViewEmailsDisplay() {
    state = state.copyWith(addEmailDisplay: false);
  }

  void addEmails(List<String> emails, EmailListRadioButtonType type) {
    switch (type) {
      case EmailListRadioButtonType.cSuite:
        state = state.copyWith(emailsCSuite: [...state.emailsCSuite, ...emails].toSet().toList());
      case EmailListRadioButtonType.ceo:
        state = state.copyWith(emailsCeo: [...state.emailsCeo, ...emails].toSet().toList());
      case EmailListRadioButtonType.employee:
        state = state.copyWith(emailsEmployee: [...state.emailsEmployee, ...emails].toSet().toList());
    }
  }

  void clearEmails() {
    state = CurrentEmailListState();
  }
}
