import 'package:flutter/material.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({super.key});

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/bg.jpg'),
            radius: 25.0,
          ),
          Text('namw'),
        ],
      ),
    );
  }
}
