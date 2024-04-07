import 'package:flutter/material.dart';

class SuccessAlert {
  static void show(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );

    // Access the ScaffoldMessengerState using a GlobalKey
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

