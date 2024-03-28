import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dailyme/screens/Home.dart';
import 'package:dailyme/constants/navBar/bottomNavbar.dart';
import 'package:get/get.dart';
import 'package:dailyme/screens/profile/profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavyBar(
      currentIndex: currentIndex,
      onItemSelected: (index) async {
        onItemSelected(index);
        if (index == 0) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? token = prefs.getString('token');
            Get.to(Home(token: token), transition: Transition.fade);
          } else if (index == 1) {
            Get.to(Profile(), transition: Transition.zoom);
          }
      },
      context: context, // Pass the context here
    );
  }
}
