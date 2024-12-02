import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

// Holds current widget being displayd to user in Auth Process.`

class AuthState {
  final String inputEmail;
  final String inputPassword;
  final User? currentUser;

  const AuthState({this.inputEmail = '', this.inputPassword = '', this.currentUser});

  AuthState copyWith({String? inputEmail, String? inputPassword, User? currentUser}) {
    return AuthState(inputEmail: inputEmail ?? this.inputEmail, inputPassword: inputPassword ?? this.inputPassword, currentUser: currentUser ?? this.currentUser);
  }
}

class AuthFirestoreService extends StateNotifier<AuthState> {
  final logger = Logger("AuthFireStoreService");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthFirestoreService() : super(AuthState());

  //Set up listening to user changes. If user logged in set user state
  void initState() {
    _auth.userChanges().listen((User? user) {
      state = state.copyWith(currentUser: user);
      if (user != null) {
        logger.info("User signed in with UID: ${user.uid}");
      } else {
        logger.info("No user signed in");
      }
    });
  }

  void createUserWithEmailAndPassword() async {
    var userCred = await _auth.createUserWithEmailAndPassword(email: state.inputEmail, password: state.inputPassword);
    logger.info("Created new user ${userCred.user!.uid} and email: ${state.inputEmail}");
    signInWithEmailAndPassword(state.inputEmail, state.inputPassword);
  }

  void signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  void setInputEmail(String email) {
    state = state.copyWith(inputEmail: email);
  }

  void setInputPassword(String password) {
    state = state.copyWith(inputPassword: password);
  }

  void printState(){
    logger.info("State: ${state.inputEmail}, ${state.inputPassword}");
  }
}
