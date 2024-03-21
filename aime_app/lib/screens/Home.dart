import 'dart:ffi';

import 'package:dailyme/screens/home/HomeHeader.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/screens/home/UserSection.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dailyme/constants/appBar.dart';


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
    return const Scaffold(
      appBar:CustomAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // HomeHeader(),
            UserSection()
          ],
        ),
      )),
    );
  }
}
