import 'package:dailyme/constants/appBar.dart';
import 'package:dailyme/constants/drawer.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:dailyme/screens/assets/assetForm.dart';
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
      drawer: const drawer(),
      body: SafeArea(child: Card(
        elevation: 5.0,
          color: bg1,
        child: Container(
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Assets")
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: bg1,
        child: const Icon(Icons.add,size:30.0, color: iconColor1,),
        onPressed: (){
          showDialog(
            context: context, 
            builder: (BuildContext context) => AlertDialog(
              content: AssetForm(),

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
