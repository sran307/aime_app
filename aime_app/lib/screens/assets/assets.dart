import 'package:dailyme/constants/appBar.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<Assets> createState() => _Assets();
}

class _Assets extends State<Assets> {
  int _currentIndex = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(child: Card(
        elevation: 5.0,
          color: bg1,
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Assets")
                ],
              ),
              Expanded(child: Row(
                children: [
                  
                ],
              ))
            ],
          ),
        ),
      )),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
