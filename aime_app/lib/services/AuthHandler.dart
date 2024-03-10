import 'package:dailyme/screens/Home.dart';
import 'package:dailyme/screens/Loading.dart';
import 'package:dailyme/services/Biometric.dart';
import 'package:dailyme/screens/auth_pages/login_pages/PinLogin.dart';
import 'package:flutter/material.dart';


class AuthHandler extends StatefulWidget {
  const AuthHandler({super.key});

  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  final Biometric _biometricAuth = Biometric();

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool isAuthenticated = await _biometricAuth.authenticateWithBiometrics();
    if (isAuthenticated) {
      // Biometric authentication successful, navigate to home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Home()),
      );
    } else {
      // Biometric authentication failed or not available, navigate to pattern lock screen
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (_) => OtherLogin()),
      // );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PinLogin()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}