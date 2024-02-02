import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AvatarWithLoader extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  final double loaderSize;

  AvatarWithLoader({
    required this.imageUrl,
    required this.imageSize,
    required this.loaderSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: imageSize / 2,
          backgroundImage: AssetImage(imageUrl),
        ),
        SpinKitCircle(
          color: const Color.fromARGB(255, 170, 9, 9), // Change the color as needed
          size: loaderSize,
        ),
      ],
    );
  }
}


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AvatarWithLoader(
          imageUrl: 'assets/images/bg.jpg', // Replace with your image URL
          imageSize: 200.0, // Set the desired size of the CircleAvatar
          loaderSize: 50.0, // Set the desired size of the loader
        ),
      ),
    );
  }
}