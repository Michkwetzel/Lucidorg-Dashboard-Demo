import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/config/enums.dart';

// Holds current widget being displayd to user in Auth Process.`

class UserState {
  final User? currentUser;
  final Permission? permission;
  final bool error;

  UserState({this.currentUser, this.permission, this.error = false});

  UserState copyWith({User? currentUser, Permission? permission, bool? error}) {
    return UserState(currentUser: currentUser ?? this.currentUser, permission: permission ?? this.permission, error: error ?? this.error);
  }
}

class AuthFirestoreServiceNotifier extends StateNotifier<UserState> {
  final logger = Logger("AuthFireStoreService");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthFirestoreServiceNotifier() : super(UserState());

  //Set up listening to user changes. If user logged in set user state
  void initState() {
    _auth.userChanges().listen((User? user) async {
      state = state.copyWith(currentUser: user);
      if (user != null) {
        setPermission();
        logger.info("User signed in with UID: ${user.uid}, Email: ${user.email}, Permission: ${state.permission}");
      } else {
        logger.info("No user signed in");
      }
    });
  }

  void setPermission() async {
    try {
      // final idTokenResult = await state.currentUser!.getIdTokenResult();
      // String? claims = idTokenResult.claims?['role'] as String?;
      //Note this updates too slowly. so now check from db user doc
      final userDocRef = await _firestore.collection('users').doc(state.currentUser!.uid).get();
      final claim = userDocRef.data()?['permission'];
      if (claim != null) {
        switch (claim) {
          case 'exec':
            state = state.copyWith(permission: Permission.exec);
            break;
          case 'employee':
            state = state.copyWith(permission: Permission.employee);
            break;
          case 'guest':
            state = state.copyWith(permission: Permission.guest);
            break;
          default:
            state = state.copyWith(error: true, permission: Permission.error);
        }
      }
      logger.info("Set App wide permission for ${state.currentUser?.uid} to ${state.permission}");
    } on Exception catch (e) {
      state = state.copyWith(error: true);
      logger.severe("Unable to get permissions ${state.currentUser?.uid}, Email: ${state.currentUser?.email} $e");
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

  void logState() {
    logger.info(state);
  }
}
