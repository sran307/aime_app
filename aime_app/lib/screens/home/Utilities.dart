import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:get/get.dart';
import 'package:dailyme/screens/todo/ToDoList.dart';

class Utilities extends StatelessWidget {
  const Utilities({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.deepOrange,
      elevation: 0.0,
      color: kPrimaryColor,
      child: SizedBox(
        // width: double.infinity, // Take the full width
        height: MediaQuery.of(context).size.height * 0.4,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(ToDoList(), transition: Transition.circularReveal);
                    },
                    child: Text('To Do'),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
