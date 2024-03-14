import 'dart:convert';

import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/screens/auth_pages/login.dart';
import 'package:dailyme/screens/Home.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/services/deviceDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenHandler {
  final BuildContext context;
  late SharedPreferences prefs;

  TokenHandler(this.context);

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> loadKey(String pin) async {
    await initSharedPref(); // Initialize SharedPreferences
    Map<String, dynamic> jsonData =
        await getToken(pin); // Define this function in auth.dartprint
    if (jsonData['status'] == 200) {
      prefs.setString('token', jsonData['token'].toString());
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home(token: jsonData['token'])),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginForm()),
        (route) => false,
      );
    }
  }

  Future<void> submitForm(data) async {
    DeviceDetails deviceDetails = DeviceDetails();
    await deviceDetails.initPlatformState();
    data['deviceDetails'] = deviceDetails.deviceData;
    dynamic response = await Register(data);
    if (response.statusCode == 201) {
      // Parse the response JSON data
      final jsonData = jsonDecode(response.body);
      // Now you can use the parsed data as needed
      loadKey(jsonData['pin']);
    } else {
      ApiResponse apiResponse = ApiResponse();
      var errorMsg = await apiResponse.errorData(response);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('${errorMsg}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    
  }
}
