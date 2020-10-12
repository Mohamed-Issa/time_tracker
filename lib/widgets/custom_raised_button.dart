import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {this.child,
      this.color,
      this.borderRadius: 2.0,
      this.onPressed,
      this.height: 50.0})
      : assert(borderRadius != null);

  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
