import 'dart:convert';

import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataEncryptor.dart';
import 'package:dailyme/services/urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// LOGIN LOGIC IMPLEMENTED IN GETTOKEN FUNCTION
Future<dynamic> getToken(pin) async {
  ApiResponse apiResponse = ApiResponse();

  encryptor newData = encryptor();
  var pinData = {"pin": pin};
  Map<String, dynamic> encData = await newData.encrypt(pinData);
  try {
    final Response = await http.post(Uri.parse(loginUrl),
        headers: {'Accept': 'application/json'}, body: jsonEncode(encData));
    // Parse the JSON response
    // Map<String, dynamic> jsonResponse = jsonDecode(Response.body);

    return Response;
  } catch (e) {
    final response = http.Response('{"status": "Server Not Found"}', 400);
    return response;
  }
}

Future<bool> checkExist(deviceData) async {
  encryptor newData = encryptor();
  Map<String, dynamic> encData = await newData.encrypt(deviceData);
  try {
    final Response = await http.post(Uri.parse(checkExistUrl),
        headers: {'Accept': 'application/json'}, body: jsonEncode(encData));

    // Parse the JSON response
    Map<String, dynamic> jsonResponse = jsonDecode(Response.body);
// Extract each field separately
    int status = jsonResponse['status'];
    bool isExist = jsonResponse['isExist'];
    // print(status);
    // print(isExist);
    return isExist;
  } catch (e) {
    return false;
  }
}

Future<dynamic> Register(data) async {
  // ApiResponse apiResponse = ApiResponse();
  encryptor newData = encryptor();
  Map<String, dynamic> encData = await newData.encrypt(data);
  try {
    final Response = await http.post(Uri.parse(registerUrl),
        headers: {'Accept': 'application/json'}, body: jsonEncode(encData));

    return Response;
  } catch (e) {
    final response = http.Response('{"status": "Server Not Found"}', 400);
    return response;
  }
}

Future<dynamic> CommonSubmit(data, url) async {
  // ApiResponse apiResponse = ApiResponse();
  encryptor newData = encryptor();
  Map<String, dynamic> encData = await newData.encrypt(data);

  try {
    final Response = await http.post(Uri.parse(url),
        headers: {'Accept': 'application/json'}, body: jsonEncode(encData));

    return Response;
  } catch (e) {
    final response = http.Response('{"status": "Server Not Found"}', 400);
    return response;
  }
}

Future<dynamic> GetData(url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  encryptor newData = encryptor();
  Map<String, dynamic> encData = await newData.encrypt(token);

  try {
    final Response = await http.post(Uri.parse(url),
        headers: {'Accept': 'application/json'}, body: jsonEncode(encData));

    return Response;
  } catch (e) {
    final response = http.Response('{"status": "Server Not Found"}', 400);
    return response;
  }
}