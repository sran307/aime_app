import 'package:flutter/material.dart';

class HomeCard1 extends StatefulWidget {
  const HomeCard1({super.key});

  @override
  State<HomeCard1> createState() => _HomeCard1State();
}

class _HomeCard1State extends State<HomeCard1> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Adjust elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // Adjust border radius as needed
      ),
      child: Container(
        height: 100, // Adjust height as needed
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(15), // Match the border radius of the card
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 70, 185, 122),
              Color.fromARGB(255, 59, 170, 142)
            ], // Specify your gradient colors
          ),
        ),
        child: const Row(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/bg.jpg'),
              radius: 50.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1.0),
            child: Text('Name'),
          ),
        ]),
      ),
    );
  }
}
