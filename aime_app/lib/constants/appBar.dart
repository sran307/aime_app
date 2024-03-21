import 'package:dailyme/screens/events/EventList.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/screens/home/icon_btn_with_counter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBtnWithCounter(
            svgSrc: Icons.menu,
            press: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => EventList()),
                (route) => false,
              );
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
              press: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => EventList()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(width: 8),
            IconBtnWithCounter(
              svgSrc: Icons.notifications_active,
              numOfitem: 3,
              press: () {},
            ),
            const SizedBox(width: 8),
            IconBtnWithCounter(
              svgSrc: Icons.logout,
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
