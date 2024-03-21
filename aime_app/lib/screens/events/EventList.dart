import 'package:dailyme/screens/events/EventItem.dart';

import 'package:dailyme/constants/FadeAnimation.dart';
import 'package:dailyme/constants/appBar.dart';

import 'package:flutter/material.dart';
import 'package:dailyme/screens/home/userHeader.dart';
import 'package:dailyme/screens/home/icon_btn_with_counter.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                  1.0, EventIem(image: 'assets/images/img.jpg', date: 17)),
            ],
          ),
        )));
  }
}
