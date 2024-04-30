import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';

class TopBar extends StatelessWidget{
  final String title;
  const TopBar({
    required this.title,
    super.key,
  });

  @override

  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height:100,
      decoration: BoxDecoration(
        gradient: kSuccessGradientColor
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Text(
          title,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          )
        )
      )
    );
  }
}