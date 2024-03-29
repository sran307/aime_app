import 'package:flutter/material.dart';

class PinNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  PinNumber({required this.textEditingController, required this.outlineInputBorder});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(contentPadding: EdgeInsets.all(16.0),
        border:outlineInputBorder,
        filled: true,
        fillColor: Colors.white30,
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 21.0,
        color: Color.fromARGB(255, 75, 202, 224),

      ),
      ),
    );
  }
}
