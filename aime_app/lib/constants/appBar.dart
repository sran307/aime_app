import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/screens/events/EventList.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/screens/home/icon_btn_with_counter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(0, 210, 226, 226),
      elevation: 0,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBtnWithCounter(
            svgSrc: Icons.menu,
            Icolor: kSuccessColor,
            press: () {
              Get.to(EventList(), transition: Transition.zoom);
            },
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 16),
            IconBtnWithCounter(
              svgSrc: Icons.event,
              Icolor: kSuccessColor,
              press: () {
                Get.to(EventList(), transition: Transition.downToUp);
              },
            ),
            const SizedBox(width: 8),
            IconBtnWithCounter(
              svgSrc: Icons.notifications_active,
              Icolor: kSuccessColor,
              numOfitem: 3,
              press: () {},
            ),
            const SizedBox(width: 8),
            IconBtnWithCounter(
              svgSrc: Icons.logout,
              Icolor: kSuccessColor,
              numOfitem: 0,
              press: () {},
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
