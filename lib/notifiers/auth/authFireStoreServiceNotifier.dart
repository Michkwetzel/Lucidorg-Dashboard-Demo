import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/notifiers/ActiveAssessmentData/ActiveAssessmentDataNotifier.dart';
import 'package:platform_front/services/firebaseServiceNotifier.dart';

// Holds current widget being displayd to user in Auth Process.`

class UserState {
  final User? currentUser;
  final Permission? permission;
  final String? companyUID;
  final bool error;

  UserState({this.currentUser, this.permission, this.error = false, this.companyUID});

  UserState copyWith({User? currentUser, Permission? permission, bool? error, String? companyUID}) {
    return UserState(currentUser: currentUser ?? this.currentUser, permission: permission ?? this.permission, error: error ?? this.error, companyUID: companyUID ?? this.companyUID);
  }
}

class AuthFirestoreServiceNotifier extends StateNotifier<UserState> {
  final logger = Logger("AuthFireStoreService");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseServiceNotifier firebaseServiceNotifier;
  final ActiveAssessmentDataNotifier activeAssessmentDataNotifier;

  AuthFirestoreServiceNotifier({required this.activeAssessmentDataNotifier, required this.firebaseServiceNotifier}) : super(UserState());

  //Set up listening to user changes. If user logged in set user state
  void initState() {
    _auth.userChanges().listen((User? user) async {
      if (user != null) {
        //state = state.copyWith(currentUser: user);
        getUserInfo(user);
        logger.info("User signed in with UID: ${user.uid}, Email: ${user.email}, Permission: ${state.permission}");
      } else {
        logger.info("No user signed in");
      }
    });
  }

  void getUserInfo(User? user) async {
    try {
      final userDocRef = await _firestore.collection('users').doc(user!.uid).get();
      //Get permision
      final permission = parsePermission(userDocRef.data()?['permission']);
      //Get companyUID
      final companyUID = userDocRef.data()?['companyUID'];
      //Get latest Survey if it exist
      await activeAssessmentDataNotifier.setAssessmentDocName(companyUID);

      state = state.copyWith(currentUser: user, permission: permission, companyUID: companyUID);
      logger.info('Current user: ${state.currentUser?.uid}, companyUID: ${state.companyUID}, permission: ${state.permission}, Latest Survey: ${activeAssessmentDataNotifier.activeSurvey}}');
    } on Exception catch (e) {
      state = state.copyWith(error: true);
      logger.severe("Unable to get permissions ${state.currentUser?.uid}, Email: ${state.currentUser?.email} $e");
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

  Future<void> deleteAccount() async {
    logger.info("Deleted account that was just created");
    await _auth.currentUser!.delete();
  }

  //Create user, if Successfull, sign them in.
  Future<void> createUserWithEmailAndPassword(String inputEmail, String inputPassword) async {
    logger.info("Create user Account started inputEmail: $inputEmail");
    _auth.signOut();

    var userCred = await _auth.createUserWithEmailAndPassword(email: inputEmail, password: inputPassword);
    logger.info("Success creating Google Auth Account, UID: ${userCred.user?.uid}, email: ${userCred.user?.email}");
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    _auth.signOut();
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<dynamic> signinWithGoogle() async {
    print('Signin with Google');
    _auth.signOut();
    return await _auth.signInWithPopup(GoogleAuthProvider());
  }

  void signOutUser(){
    _auth.signOut();
    state = state.copyWith(currentUser: null, permission: null, companyUID: null);
  }

  void logState() {
    logger.info(state);
  }
}
