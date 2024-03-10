import 'package:dailyme/screens/auth_pages/login.dart';
import 'package:dailyme/screens/Home.dart';
import 'package:dailyme/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenHandler {
  final BuildContext context;
  late SharedPreferences prefs;

  TokenHandler(this.context);

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> loadKey(String pin) async {
    await initSharedPref(); // Initialize SharedPreferences
    bool token = await getToken(pin); // Define this function in auth.dartprint
    print(token);
    if (!token) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginForm()),
        (route) => false,
      );
    } else {
      prefs.setString('token', token.toString());
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false,
      );
    }
  }

  Future<void> submitForm(data) async {
    String token = await Register(data);
    loadKey(token);
  }
}
