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
        height: MediaQuery.of(context).size.height * 0.35,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Center(child: Text('UTILITIES'))
                    ),
                  ),
              
                  
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ToDoList(), transition: Transition.zoom);
                        },
                        child: Text('To Do'),
                      ),
                    ),
                  ),
              
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ToDoList(), transition: Transition.circularReveal);
                        },
                        child: Text('Alarm'),
                      ),
                    ),
                  ),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ToDoList(), transition: Transition.circularReveal);
                        },
                        child: Text('Goals'),
                      ),
                    ),
                  ),
              
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ToDoList(), transition: Transition.circularReveal);
                        },
                        child: Text('Assets'),
                      ),
                    ),
                  ),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ToDoList(), transition: Transition.circularReveal);
                        },
                        child: Text('Liability'),
                      ),
                    ),
                  ),
              
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ToDoList(), transition: Transition.circularReveal);
                        },
                        child: Text('Trade'),
                      ),
                    ),
                  ),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ToDoList(), transition: Transition.circularReveal);
                        },
                        child: Text('Locker'),
                      ),
                    ),
                  ),
              
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ToDoList(), transition: Transition.circularReveal);
                        },
                        child: Text('Trade'),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
