import 'dart:async';
import 'dart:developer' as developer;

import 'package:dailyme/screens/auth_pages/register.dart';
import 'package:dailyme/services/AuthHandler.dart';
import "package:flutter/material.dart";
import 'package:dailyme/screens/Loading.dart';
import 'package:dailyme/screens/Home.dart';
import 'screens/auth_pages/login.dart';
void main() async {
  // runApp(const MyApp());
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (dynamic error, dynamic stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily ME',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loading(),
    );
  }
}