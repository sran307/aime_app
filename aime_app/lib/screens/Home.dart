import 'package:flutter/material.dart';
import 'package:dailyme/screens/extends/HomeCard1.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 51, 72, 80),
          title: const Text(
            'HOME',
            style: TextStyle(
              color: Color.fromARGB(99, 100, 185, 200),
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 5, // Adjust elevation as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust border radius as needed
                      ),
                      child: Container(
                        height: 100, // Adjust height as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              15), // Match the border radius of the card
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
                              backgroundImage:
                                  AssetImage('assets/images/bg.jpg'),
                              radius: 50.0,
                            ),
                            
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text('Name'),
                          ),
                        ]),
                      ),
                    ),
                    HomeCard1(),
                  ],
                ),
              ))
            ])));
  }
}
