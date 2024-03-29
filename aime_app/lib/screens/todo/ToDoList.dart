import 'package:dailyme/constants/appBar.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/screens/todo/Today.dart';
import 'package:dailyme/screens/todo/Tomorrow.dart';
import 'package:dailyme/screens/todo/Yesterday.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  int _currentIndex = 5;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Tomorrow(),
                    Today(),
                    Yesterday(),
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
