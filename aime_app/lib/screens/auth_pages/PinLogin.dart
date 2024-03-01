import 'package:dailyme/screens/auth_pages/OtpScreen.dart';
import 'package:flutter/material.dart';

class PinLogin extends StatefulWidget {
  const PinLogin({super.key});

  @override
  State<PinLogin> createState() => _PinLoginState();
}

class _PinLoginState extends State<PinLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(0, 200, 89, 1),
            const Color.fromRGBO(0, 100, 0, 0.867)
          ],
          begin: Alignment.topRight)
        ),
        child: OtpScreen(),
      ),
    );
  }
}