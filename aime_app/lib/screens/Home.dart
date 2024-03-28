import 'dart:ffi';

import 'package:dailyme/screens/home/HomeHeader.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/screens/home/UserSection.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dailyme/constants/appBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailyme/constants/bottomNavbar.dart';


class Home extends StatefulWidget {
  final token;
  const Home({@required this.token, Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late var name = '';
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    name = jwtDecodedToken['name'] ?? '';
  }

  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return Scaffold(
      appBar:CustomAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // HomeHeader(),
            SizedBox(height: 20.0,),
            UserSection()
          ],
        ),
      )),


      bottomNavigationBar: CustomBottomNavyBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) async {
          setState(() => _currentIndex = index);
          if (index == 0) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? token = prefs.getString('token');

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home(token: token)),
              (route) => false,
            );
          }
        },
        context: context, // Pass the context here
      ),
    );
  }
}
