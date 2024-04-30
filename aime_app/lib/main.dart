import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailyme/screens/Home.dart';
import 'package:dailyme/screens/Loading.dart';
import 'package:dailyme/constants/flashMessage.dart';
import 'package:dailyme/constants/theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dailyme/services/notificartion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();

  SharedPreferences prefs;
  String? token;

  prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Daily ME',
      theme: AppTheme.lightTheme(context),
      home: ScaffoldMessenger(
        key: FlashMessage.scaffoldMessengerKey,
        child: token != null && !JwtDecoder.isExpired(token!)
            ? Home(token: token!)
            : Loading(),
      ),
    );
  }
}
