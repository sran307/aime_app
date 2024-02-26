import 'dart:io';

import 'package:dailyme/services/AuthHandler.dart';
import 'package:dailyme/services/Biometric.dart';
import 'package:dailyme/screens/auth_pages/OtherLogin.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? AuthHandler() : OtherLogin();
    // return Platform.isAndroid ?  OtherLogin() : AuthHandler();
  }
}