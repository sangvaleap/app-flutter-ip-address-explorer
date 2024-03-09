import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static void to(BuildContext context, Widget page,
      [bool fullscreenDialog = false]) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => page, fullscreenDialog: fullscreenDialog),
    );
  }

  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void toAndReplace(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
