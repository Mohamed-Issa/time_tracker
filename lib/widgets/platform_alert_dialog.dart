import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:time_tracker_flutter_course/widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatFormWidget {
  final String title;
  final String content;
  final String cancelActiontext;
  final String defaultActionText;

  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    this.cancelActiontext,
    @required this.defaultActionText,
  })  : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (content) => this,
          )
        : await showDialog<bool>(
            context: context,
            barrierDismissible: true,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];
    if (cancelActiontext != null) {
      actions.add(
        PlatformAlertDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelActiontext)),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(defaultActionText)),
    );
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatFormWidget {
  final Widget child;
  final VoidCallback onPressed;

  PlatformAlertDialogAction({this.child, this.onPressed});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(onPressed: onPressed, child: child);
  }
}
