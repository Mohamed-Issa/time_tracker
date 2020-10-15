import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Future<User> signInAnonymously();

  User currentUser();

  Future<void> signOut();

  Stream<User> get onAuthStateChange;

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<User> singInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return authResult.user;
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing google auth token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['public_profile']);
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(result.accessToken.token),
      );
      return authResult.user;
    } else {
      throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing google auth token');
    }
  }

  @override
  Future<User> singInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult.user;
  }

  @override
  Future<void> signOut() async {
    final googleSingIn = GoogleSignIn();
    await googleSingIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    _firebaseAuth.signOut();
  }
}
