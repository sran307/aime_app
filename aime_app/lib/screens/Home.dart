import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

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
                    Container(
                      color:Colors.red,
                      
                    )
                  ],
                ),
              )
            )]
        )));
  }
}