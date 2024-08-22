import 'package:dailyme/constants/appBar.dart';
import 'package:dailyme/constants/drawer.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/screens/stocks/TradeButtons.dart';

class stockHome extends StatefulWidget {
  const stockHome({super.key});

  @override
  State<stockHome> createState() => _stockHomeState();
}

class _stockHomeState extends State<stockHome> {
  @override
  int _currentIndex = 6;
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(),
      drawer: const drawer(),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    TradeButtons()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}