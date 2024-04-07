import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailyme/screens/todo/ToDoList.dart';

class elevButton extends StatelessWidget {
  final String routeName;
  final String name;
  final Transition transition;

  elevButton(this.routeName, this.name, {this.transition = Transition.fade});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('$routeName');
          },
          child: Text('$name'),
        ),
      ),
    );
  }
}
