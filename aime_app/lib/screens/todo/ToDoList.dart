import 'package:dailyme/constants/appBar.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/screens/todo/Today.dart';
import 'package:dailyme/screens/todo/Tomorrow.dart';
import 'package:dailyme/screens/todo/Yesterday.dart';
import 'package:dailyme/screens/todo/TodoForm.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:dailyme/services/urls.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  int _currentIndex = 5;
  Widget build(BuildContext context) {
    Future<void> initState() async {
      TokenHandler tokenHandler = TokenHandler(context);
      dynamic todoData = await tokenHandler.FetchData(todoList);
    }

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return TodoForm();
            },
          );
        },
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
