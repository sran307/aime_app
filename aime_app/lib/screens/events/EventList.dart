import 'package:dailyme/screens/events/EventItem.dart';
import 'package:dailyme/constants/animations/FadeAnimation.dart';
import 'package:dailyme/constants/appBar.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:dailyme/screens/events/eventForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailyme/screens/Home.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  int _currentIndex = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FadeAnimation(
                    1.0,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      child: const TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            hintText: "Search Event",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.0, EventIem(image: 'assets/images/img.jpg', date: 17)),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.0, EventIem(image: 'assets/images/img.jpg', date: 17)),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.0, EventIem(image: 'assets/images/img.jpg', date: 17)),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return eventForm();
                      },
                    );
                  },
                  child: Text('Add')),
            ),
          )
        ],
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
