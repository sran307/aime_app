import 'package:dailyme/screens/events/EventList.dart';
import 'package:dailyme/screens/home/userHeader.dart';
import 'package:flutter/material.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const Expanded(child: SearchField()),
          const Expanded(child: UserHeader()),

          const SizedBox(width: 16),
          IconBtnWithCounter(
            svgSrc: Icons.event,
            press: () {
              Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => EventList()),
        (route) => false,
      );
            },
          ),
          const SizedBox(width: 8),
          IconBtnWithCounter(
            // svgSrc: "assets/icons/Bell.svg",
            svgSrc:Icons.notifications_active,
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}