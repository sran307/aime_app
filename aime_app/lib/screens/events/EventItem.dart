import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';

Widget EventIem({image, date}){
  return Row(children: [
    Container(
      width: 50,
      height: 150,
      margin: EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Text(date.toString(),
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 25.0,
            fontWeight: FontWeight.bold
          ), 
          ),
          Text("SEP", style: TextStyle(
          color: kPrimaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold)),
        ],
      ),
    ),
    Expanded(child: Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(image),
        fit: BoxFit.cover)
      ),
      child:Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(colors: [
            Colors.black87,
            Colors.black12
          ])
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Testing Data', 
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.white,),
                SizedBox(width: 10,),
                Text('19: 00 PM', style: TextStyle(color: Colors.white, 
                fontSize: 20.0, fontWeight: FontWeight.bold),)
              ],
            )
          ],
        ),
      )
    ))
  ],);
}