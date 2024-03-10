import 'dart:async';
import 'dart:developer' as developer;

import 'package:dailyme/screens/auth_pages/register.dart';
import 'package:dailyme/services/AuthHandler.dart';
import "package:flutter/material.dart";
import 'package:dailyme/screens/Loading.dart';
import 'package:dailyme/screens/Home.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth_pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runZonedGuarded(() {
    runApp(MyApp(token: token));
  }, (dynamic error, dynamic stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });
}


class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily ME',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: token != null && !JwtDecoder.isExpired(token!)
          ? Home(token: token!)
          : Loading(),
    );
  }
}

