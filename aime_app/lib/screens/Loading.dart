import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dailyme/screens/auth_pages/login.dart';
import 'package:dailyme/screens/auth_pages/register.dart';
import 'package:dailyme/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';

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
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    _loadKey();
    getConnectivity();
  }

  void _loadKey() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginForm()),
        (route) => false,
      );
    } else {
      if (token == 'true') {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => RegisterForm()),
          (route) => false,
        );
      }
    }
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && !isAlertSet) {
        showDialogBox();
        setState(() => isAlertSet = true);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
          color: const Color.fromARGB(
              255, 170, 9, 9), // Change the color as needed
          size: widget.loaderSize,
        ),
      ],
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('data'),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'cancel');
                  setState(() => isAlertSet = false);
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected) {
                    showDialogBox();
                    setState(() => isAlertSet = true);
                  }
                },
                child: const Text('ok'))
          ],
        ),
      );
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
