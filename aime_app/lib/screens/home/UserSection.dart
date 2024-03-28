import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/screens/home/icon_btn_with_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserSection extends StatefulWidget {
  const UserSection({super.key});

  @override
  State<UserSection> createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  get press => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        
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
                gradient: kSuccessGradientColor,
              ),
              child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 40.0),
                    Text('Name'),
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
            Positioned(
                bottom: 40.0,
                right: 220.0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: press,
                  child: IconBtnWithCounter(
                    svgSrc: Icons.camera,
                    Icolor: kPrimaryColor,
                    press: () {
                      //       Navigator.of(context).pushAndRemoveUntil(
                      // MaterialPageRoute(builder: (context) => EventList()),
                      // (route) => false,
                      // );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
