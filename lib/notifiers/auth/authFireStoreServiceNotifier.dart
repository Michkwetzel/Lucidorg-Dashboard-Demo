import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/notifiers/companyInfo/companyInfoNotifer.dart';
import 'package:platform_front/notifiers/createAssessment/emailListNotifer.dart';
import 'package:platform_front/notifiers/userResultsData/userResultsData.dart';
import 'package:platform_front/notifiers/userProfileData/userProfileData.dart';
import 'package:platform_front/services/firebaseServiceNotifier.dart';

// Auth services. Holds the currently signed in user as its state

class AuthFirestoreServiceNotifier extends StateNotifier<User?> {
  final logger = Logger("AuthFireStoreService");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseServiceNotifier firebaseServiceNotifier;
  final UserResultsData activeAssessmentDataNotifier;
  final UserProfileDataNotifier userDataNotifier;
  final EmailListNotifier emailListNotifier;
  final CompanyInfoNotifer companyInfoNotifer;

  AuthFirestoreServiceNotifier(
      {required this.emailListNotifier, required this.companyInfoNotifer, required this.activeAssessmentDataNotifier, required this.firebaseServiceNotifier, required this.userDataNotifier})
      : super(null);

  //Set up listening to user changes. If user logged in set user state
  void initState() {
    _auth.userChanges().listen((User? user) async {
      if (user != null) {
        state = user;
        logger.info("User signed in with UID: ${user.uid}, Email: ${user.email}}");
      } else {
        logger.info("No user signed in");
      }
    });
  }

  Future<void> deleteAccount() async {
    logger.info("Deleted account that was just created");
    await _auth.currentUser!.delete();
  }

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

  void signOutUser() {
    _auth.signOut();
    userDataNotifier.clearUserData();
    companyInfoNotifer.clearCompanyInfo();
    emailListNotifier.clearEmails();
  }

  void logState() {
    logger.info(state.toString());
  }
}
