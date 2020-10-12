import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home_page.dart';
import 'package:time_tracker_flutter_course/app/signIn/sign_in_screen.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({@required this.auth});

  final AuthBase auth;

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  User _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    widget.auth.onAuthStateChange.listen((user) {
      print('user: ${user?.uid}');
    });
  }

  void _checkCurrentUser() {
    User user = widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
    print('user id: ${user.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: widget.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;
            if (user == null) {
              return SignInScreen(
                auth: widget.auth,
                onSignIn: _updateUser,
              );
            } else {
              return HomePage(
                auth: widget.auth,
                signOut: () => _updateUser(null),
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
