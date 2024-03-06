import 'dart:convert';
import 'dart:ffi';

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

Future<String> getToken() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    // print(loginUrl);
    final Response = await http.get(Uri.parse(loginUrl));
    print(Response);
    apiResponse.data = {'success': 'true'};
  } catch (e) {
    apiResponse.error = smw;
  }
  return 'true';
}

Future<bool> checkExist(deviceData) async {
  ApiResponse apiResponse = ApiResponse();
  
  encryptor newData = encryptor();
  Map<String, dynamic> encData = await newData.encrypt(deviceData); 
  print(encData);
  print(checkExistUrl);
  try {
    final Response = await http.post(Uri.parse(checkExistUrl),
        headers: {'Accept': 'application/json'},
        body: jsonEncode(encData));
    print(Response.statusCode);
    print(Response.body);
    apiResponse.data = {'success': 'true'};
  } catch (e) {
    print('error');
    print(e);
    apiResponse.error = smw;
  }
  return false;
}
