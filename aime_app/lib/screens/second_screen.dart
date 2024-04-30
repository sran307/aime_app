import 'package:dailyme/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';

class SecondScreen extends StatelessWidget{
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
        gradient: kSuccessGradientColor
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:const Column(children: [
            TopBar(title: 'Second Screen'),
            Spacer(),
            Center(child: Text("Navidator"),),
            Spacer()
          ],)
        )
        )

    );
  }
}