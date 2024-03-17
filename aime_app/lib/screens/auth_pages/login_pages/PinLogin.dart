import 'package:dailyme/screens/auth_pages/login_pages/OtpScreen.dart';
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
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 51, 72, 80),
        title: const Text(
          'Sign In',
          style: TextStyle(
            color: Color.fromARGB(99, 100, 185, 200),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(248, 248, 248, 1),
            Color.fromARGB(221, 254, 255, 255)
          ],
          begin: Alignment.topRight)
        ),
        child: OtpScreen(),
      ),
    );
  }
}