import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/userResultsData/userResultsData.dart';

class UserProfileState {
  final String? userUID;
  final String? email;
  final String? companyUID;
  final Permission? permission;

  UserProfileState({this.userUID, this.permission, this.companyUID, this.email});

  UserProfileState copyWith({String? userUID, Permission? permission, bool? error, String? companyUID, String? email}) {
    return UserProfileState(userUID: userUID ?? this.userUID, permission: permission ?? this.permission, companyUID: companyUID ?? this.companyUID, email: email ?? this.email);
  }
}

class UserProfileDataNotifier extends StateNotifier<UserProfileState> {
  Logger logger = Logger("UserData");
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final UserResultsData userResultsData;

  UserProfileDataNotifier({required this.userResultsData}) : super(UserProfileState());

  String? get userUID => state.userUID;
  Permission? get permission => state.permission;
  String? get companyUID => state.companyUID;
  String? get email => state.email;

  Future<void> getUserInfo(User? user) async {
    try {
      //Get userDoc
      final userDocRef = await _firestore.collection('users').doc(user!.uid).get();
      //Get permision
      final permission = parsePermission(userDocRef.data()?['permission']);

      //Get companyUID
      final companyUID = userDocRef.data()?['companyUID'];

      //Get latest Survey if it exist
      await userResultsData.setAssessmentDocName(companyUID);

      state = state.copyWith(userUID: user.uid, permission: permission, companyUID: companyUID, email: user.email);
      logger.info('Current user: ${user.uid}, companyUID: ${state.companyUID}, permission: ${state.permission}, Latest Survey: ${userResultsData.activeSurvey}}');
    } on Exception catch (e) {
      state = state.copyWith(error: true);
      logger.severe("Unable to get permissions ${state.userUID}, Email: ${state.email} $e");
    }
  }

  Permission parsePermission(String? claim) {
    switch (claim) {
      case 'exec':
        return Permission.exec;
      case 'employee':
        return Permission.employee;
      case 'guest':
        return Permission.guest;
      default:
        return Permission.error;
    }
  }

  void clearUserData() {
    state = UserProfileState();
    logger.info("Cleared user data: ${state.userUID}, ${state.permission}, ${state.companyUID}, ${state.email}");
  }
}
