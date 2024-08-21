import 'package:dailyme/constants/animations/FadeInAnimation.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserSection extends StatefulWidget {
  const UserSection({super.key});

  @override
  State<UserSection> createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(Profile(), transition: Transition.zoom);
      },
      child: Card(
        elevation: 5, // Adjust elevation as needed
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Adjust border radius as needed
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 100, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    15), // Match the border radius of the card
                gradient: kSecondaryGradientColor,
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 40.0),
                  Text(
                    'Name',
                    style: mainHeading,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Completed'),
                        Text('75%'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: -30,
                left: 5.0,
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/bg.jpg'),
                    radius: 40.0)),
          ],
        ),
      ),
    );
  }
}
