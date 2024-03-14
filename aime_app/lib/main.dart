import 'dart:async';
import 'dart:developer' as developer;

import "package:flutter/material.dart";
import 'package:dailyme/screens/Loading.dart';
import 'package:dailyme/screens/Home.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily ME',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 27, 228, 211),
            brightness: Brightness.light
          ),
          textTheme:TextTheme(
            displayLarge:const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
            titleLarge:GoogleFonts.oswald(
              fontSize: 30,
              fontStyle: FontStyle.italic
            ),
            bodyMedium: GoogleFonts.merriweather(),
            displaySmall: GoogleFonts.pacifico(),
          ),
      ),
      home: token != null && !JwtDecoder.isExpired(token!)
          ? Home(token: token!)
          : Loading(),
      // home:Loading(),
    );
  }
}
