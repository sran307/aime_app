import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dailyme/constants/constants.dart';

class CustomBottomNavyBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onItemSelected;
  final BuildContext context; // Add context here

  const CustomBottomNavyBar({
    Key? key,
    required this.currentIndex,
    required this.onItemSelected,
    required this.context, // Accept context as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      backgroundColor: barColor,
      selectedIndex: currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: onItemSelected, // Use the provided callback
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: iconColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('User'),
          activeColor: iconColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text(
            'Messages test for mes teset test test ',
          ),
          activeColor: iconColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: iconColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
