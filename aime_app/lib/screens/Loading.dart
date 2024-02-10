import 'package:dailyme/screens/auth_pages/login.dart';
import 'package:dailyme/screens/auth_pages/register.dart';
import 'package:dailyme/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AvatarWithLoader extends StatefulWidget {
  final String imageUrl;
  final double imageSize;
  final double loaderSize;

  AvatarWithLoader({
    required this.imageUrl,
    required this.imageSize,
    required this.loaderSize,
  });

  @override
  _AvatarWithLoaderState createState() => _AvatarWithLoaderState();
}

class _AvatarWithLoaderState extends State<AvatarWithLoader> {
  

  void _loadKey() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginForm()),
        (route) => false,
      );
    }else{
      if(token == 'true'){
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RegisterForm()),
        (route) => false,
      );
      }
    }
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => RegisterForm()),
    //     (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _loadKey();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: widget.imageSize / 2,
          backgroundImage: AssetImage(widget.imageUrl),
        ),
        SpinKitCircle(
          color: const Color.fromARGB(255, 170, 9, 9), // Change the color as needed
          size: widget.loaderSize,
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
