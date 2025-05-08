import 'package:flutter/material.dart';

class MySnackBar {
  static void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
