import 'package:dailyme/constants/appBar.dart';
import 'package:dailyme/constants/drawer.dart';
import 'package:dailyme/screens/locker/LockerForm.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:dailyme/screens/locker/LockerList.dart';


class LockerIndex extends StatefulWidget {
  const LockerIndex({super.key});

  @override
  State<LockerIndex> createState() => _LockerIndexState();
}

class _LockerIndexState extends State<LockerIndex> {
  int _currentIndex = 5;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const drawer(),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
          LockerList(),
                  ],
                ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: bg1,
        child: const Icon(
          Icons.add,
          size: 30.0,
          color: iconColor1,
        ),
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return TodoForm();
          //   },
          // );
          showDialog(
              context: context,
              builder: (BuildContext context) => const AlertDialog(
                    backgroundColor: bg1,
                    content: LockerForm(),
                  ));
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