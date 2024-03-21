import 'package:dailyme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserSection extends StatefulWidget {
  const UserSection({super.key});

  @override
  State<UserSection> createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Adjust elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // Adjust border radius as needed
      ),
      child: Container(
        height: 50, // Adjust height as needed
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(15), // Match the border radius of the card
          gradient: kSuccessGradientColor,
        ),
        child: const Row(children: [
          // Padding(
          //   padding: EdgeInsets.only(left: 5.0),
          //   child: CircleAvatar(
          //     backgroundImage: AssetImage('assets/images/bg.jpg'),
          //     radius: 20.0,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(1.0),
            child: Text('Name'),
          ),
          // Expanded(
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.only(right: 10.0),
          //         child: Align(
          //           alignment: Alignment.centerRight,
          //           child: Padding(
          //               padding: EdgeInsets.all(1.0), 
          //               child: Icon(Icons.event)),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ]),
      ),
    );
  }
}
