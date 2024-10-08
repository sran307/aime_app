import 'dart:io';

import 'package:dailyme/services/AuthHandler.dart';
import 'package:dailyme/screens/auth_pages/login_pages/PinLogin.dart';
import 'package:dailyme/screens/auth_pages/login_pages/Pinput.dart';
import 'package:dailyme/screens/auth_pages/login_pages/Onboarding.dart';


import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    // return Platform.isAndroid ? AuthHandler() : OnboardingScreen();
    return Platform.isAndroid ? AuthHandler() : PinputForm();
    // return Platform.isAndroid ? AuthHandler() : PinLogin();
    // return Platform.isAndroid ?  OtherLogin() : AuthHandler();
  }
}