import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/widgets/platform_alert_dialog.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.auth});
  final AuthBase auth;
  Future<void> _signOut() async {
    try {
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout',
      cancelActiontext: 'cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        actions: [
          FlatButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
