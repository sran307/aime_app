import 'package:dailyme/constants/appBar.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/drawer.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:dailyme/screens/goals/goalForm.dart';
import 'package:flutter/material.dart';

class Goal extends StatefulWidget {
  const Goal({super.key});

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
    int _currentIndex = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: const drawer(),
      body: SafeArea(child: Column()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: bg1,
        child: const Icon(Icons.add,
        size:30.0,
        color: iconColor1),
        onPressed: (){
        showDialog(context: context, builder: (BuildContext context) => AlertDialog(
          backgroundColor: bg1,
          content: GoalForm(),
        ));
      }),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: _currentIndex, onItemSelected: (index){
        setState(() => _currentIndex = index
        );
      }),

    );
  }
}