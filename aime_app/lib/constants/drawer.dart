import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:get/get.dart';
import 'package:dailyme/screens/todo/ToDoList.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dailyme/services/notificartion.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dailyme/screens/stocks/stockHome.dart';
import 'package:dailyme/screens/assets/assets.dart';
import 'package:dailyme/screens/events/EventList.dart';
import 'package:dailyme/screens/goals/goals.dart';
import 'package:dailyme/screens/locker/LockerIndex.dart';
import 'package:dailyme/screens/Home.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: barColor,
                ),
              
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/bg.jpg'),
                    radius: 20.0,
                ),
              
              ),
              ListTile(
                leading: Icon(Icons.alarm),
                title: Text('Clock'),
                onTap:(){
                  // Get.to
                }
              ),
              ListTile(
                leading: Icon(Icons.format_list_bulleted),
                title: Text('To Do'),
                onTap: () {
                  Get.to(ToDoList(), transition: Transition.zoom);
                },
              ),
              ListTile(
                leading: Icon(Icons.api),
                title: const Text('Goals'),
                onTap:(){
                  Get.to(Goal(), transition:Transition.circularReveal);
                }
              ),
              ListTile(
                leading: Icon(Icons.event),
                title: const Text('Events'),
                onTap: (){
                  Get.to(EventList(), transition:Transition.circularReveal);
                }
              ),
              ListTile(
                leading: Icon(Icons.trending_up),
                title: const Text('Trades'),
                onTap:(){
                  Get.to(stockHome(), transition:Transition.circularReveal);
                }
              ),
              ListTile(
                leading: Icon(Icons.currency_rupee),
                title: const Text('Finance'),
                onTap:(){

                }
              ),
              ListTile(
                leading: Icon(Icons.business_center),
                title: const Text('Locker'),
                onTap:(){
                  Get.to(LockerIndex(), transition:Transition.circularReveal);
                }
              ),
              ListTile(
                leading: Icon(Icons.analytics),
                title: const Text('Assets'),
                onTap: (){
                  Get.to(Assets(), transition: Transition.circularReveal);
                }
              ),
              ListTile(
                leading: Icon(Icons.spa),
                title: const Text('Health'),
                onTap:(){

                }
              )
            ],
          ),
        ),
      );
  }
}