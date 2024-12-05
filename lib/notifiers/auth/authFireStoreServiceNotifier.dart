import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

// Holds current widget being displayd to user in Auth Process.`

class AuthFirestoreServiceNotifier extends StateNotifier<User?> {
  final logger = Logger("AuthFireStoreService");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthFirestoreServiceNotifier() : super(null);

  //Set up listening to user changes. If user logged in set user state
  void initState() {
    _auth.userChanges().listen((User? user) {
      state = user;
      if (user != null) {
        logger.info("User signed in with UID: ${user.uid}, Email: ${user.email}");
      } else {
        logger.info("No user signed in");
      }
    });
  }

  //Create user, if Successfull, sign them in.
  Future<void> createUserWithEmailAndPassword(String inputEmail, String inputPassword) async {
    var userCred = await _auth.createUserWithEmailAndPassword(email: inputEmail, password: inputPassword);
    logger.info("Created new user ${userCred.user!.uid} , email: $inputEmail , About to sign him in");
    //await signInWithEmailAndPassword(inputEmail, inputPassword);
    //logger.info("signed in user ${userCred.user!.uid} , email: $inputEmail");
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  void logState() {
    logger.info(state);
  }
}
