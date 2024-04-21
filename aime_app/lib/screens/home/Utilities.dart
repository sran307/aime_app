import 'package:dailyme/screens/events/EventList.dart';
import 'package:dailyme/screens/goals/goals.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:get/get.dart';
import 'package:dailyme/screens/todo/ToDoList.dart';
import 'package:flutter_animate/flutter_animate.dart';
class Utilities extends StatelessWidget {
  const Utilities({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        // margin:EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: kSecondaryGradientColor,
        ),
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
                          child: Center(
                              child: const Text(
                            'UTILITIES',
                            style: subHeading,
                          )
                                  .animate()
                                  .fade(duration: 500.ms)
                                  .scale(delay: 500.ms))),
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
                            Get.to(ToDoList(),
                                transition: Transition.circularReveal);
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
                            Get.to(Goal(),
                                transition: Transition.circularReveal);
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
                            Get.to(ToDoList(),
                                transition: Transition.circularReveal);
                          },
                          child: Text('Finance'),
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
                            Get.to(EventList(),
                                transition: Transition.circularReveal);
                          },
                          child: Text('Events'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(ToDoList(),
                                transition: Transition.circularReveal);
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
                            Get.to(ToDoList(),
                                transition: Transition.circularReveal);
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
                            Get.to(ToDoList(),
                                transition: Transition.circularReveal);
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
      ),
    );
  }
}
