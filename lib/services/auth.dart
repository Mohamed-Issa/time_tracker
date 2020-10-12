import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User> signInAnonymously();

  User currentUser();

  Future<void> signOut();

  Stream<User> get onAuthStateChange;
}

class Auth implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user;

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return authResult.user;
  }

  Stream<User> get onAuthStateChange {
    return _firebaseAuth.authStateChanges();
  }

  @override
  User currentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }
}
