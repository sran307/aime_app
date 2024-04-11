import 'dart:convert';

import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/models/api_response.dart';
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
    dynamic response = await getToken(pin);
    // print(response.statusCode);
    int status = response.statusCode;
    if ([200, 201, 204].contains(status)) {
      final jsonData = jsonDecode(response.body);
      prefs.setString('token', jsonData['token'].toString());
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home(token: jsonData['token'])),
        (route) => false,
      );
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, response);
    }
  }

  Future<void> submitForm(data) async {
    DeviceDetails deviceDetails = DeviceDetails();
    await deviceDetails.initPlatformState();
    data['deviceDetails'] = deviceDetails.deviceData;
    dynamic response = await Register(data);
    int status = response.statusCode;

    if ([200, 201, 204].contains(status)) {
      // Parse the response JSON data
      final jsonData = jsonDecode(response.body);
      // Now you can use the parsed data as needed
      loadKey(jsonData['pin']);
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, response);
    }
  }

  Future<void> submitCommonForm(data, url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    data['token'] = token;
    dynamic response = await CommonSubmit(data, url);
    int status = response.statusCode;
  
    if ([200, 201, 204].contains(status)) {
      // Parse the response JSON data
      final jsonData = jsonDecode(response.body);
      // Now you can use the parsed data as needed
      // SuccessAlert.show(context, jsonData['message']);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // alignment: Alignment.topCenter,
            title: Text('Success'),
            content: Text(jsonData['message'], style: const TextStyle(
              color: kSuccessColor,
            ),),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); 
                  // Get.to(ToDoList(), transition: Transition.downToUp);// Close the dialog
                },
              ),
            ],
          );
        });

    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, response);
    }
  }
}
