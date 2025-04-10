import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_HR/config/enums.dart';

class JobCreationState {
  final EmailListDisplay display;
  final List<String> emailList;

  JobCreationState({required this.display, required this.emailList});

  JobCreationState copyWith({EmailListDisplay? display, List<String>? emailList}) {
    return JobCreationState(
      display: display ?? this.display,
      emailList: emailList ?? this.emailList,
    );
  }

  factory JobCreationState.empty() {
    return JobCreationState(display: EmailListDisplay.view, emailList: ["michkwetzel@gmail.com", "michskdsd"]);
  }
}

class JobCreationNotifier extends StateNotifier<JobCreationState> {
  JobCreationNotifier() : super(JobCreationState.empty());

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
    state = state.copyWith(display: EmailListDisplay.add);
  }

  void changeToViewEmailsDisplay() {
    state = state.copyWith(display: EmailListDisplay.view);
  }
}
