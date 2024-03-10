import 'dart:convert';

import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataEncryptor.dart';
import 'package:dailyme/services/urls.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> login(String username) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final Response = await http.post(Uri.parse(loginUrl),
        headers: {'Accept': 'appication/json'}, body: {'username': username});
    print(Response);
    apiResponse.data = {'success': 'true'};
  } catch (e) {
    apiResponse.error = smw;
  }
  return apiResponse;
}

Future<bool> getToken(pin) async {
  ApiResponse apiResponse = ApiResponse();

  encryptor newData = encryptor();
  var pinData = {"pin": pin};
  Map<String, dynamic> encData = await newData.encrypt(pinData);
  print(encData);
  try {
    final Response = await http.post(Uri.parse(checkExistUrl),
        headers: {'Accept': 'application/json'}, body: jsonEncode(encData));

    // Parse the JSON response
    Map<String, dynamic> jsonResponse = jsonDecode(Response.body);
    print(jsonResponse);
    apiResponse.data = {'success': 'true'};
  } catch (e) {
    apiResponse.error = smw;
  }
  return false;
}

Future<bool> checkExist(deviceData) async {
  ApiResponse apiResponse = ApiResponse();

  encryptor newData = encryptor();
  Map<String, dynamic> encData = await newData.encrypt(deviceData);
  // print(encData);
  // print(checkExistUrl);
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
    apiResponse.error = smw;
    return false;
  }
}
