import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/screens/Loading.dart';
import 'package:dailyme/screens/events/EventList.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/screens/home/icon_btn_with_counter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: barColor,
      elevation: 0,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBtnWithCounter(
            svgSrc: Icons.menu,
            Icolor: iconColor,
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
              Icolor: iconColor,
              press: () {
                Get.to(EventList(), transition: Transition.downToUp);
              },
            ),
            const SizedBox(width: 8),
            IconBtnWithCounter(
              svgSrc: Icons.notifications_active,
              Icolor: iconColor,
              numOfitem: 3,
              press: () {},
            ),
            const SizedBox(width: 8),
            IconBtnWithCounter(
              svgSrc: Icons.logout,
              Icolor: iconColor,
              numOfitem: 0,
              press: () async {
                await clearToken();
                Get.to(Loading(), transition: Transition.zoom);
              },
            ),
          ],
        )
      ],
    );
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt_token'); // Remove the JWT token from shared preferences
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
