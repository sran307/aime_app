import 'dart:async';
import 'dart:developer' as developer;

import 'package:dailyme/constants/flashMessage.dart';
import 'package:dailyme/constants/theme.dart';
import "package:flutter/material.dart";
import 'package:dailyme/screens/Loading.dart';
import 'package:dailyme/screens/Home.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(MyApp(token: token));
}


class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily ME',
      theme: AppTheme.lightTheme(context),
      home: ScaffoldMessenger(
        key: FlashMessage.scaffoldMessengerKey,
        child: token != null && !JwtDecoder.isExpired(token!)
          ? Home(token: token!)
          : Loading(),
      )
      // home:Loading(),
    );
  }
}
