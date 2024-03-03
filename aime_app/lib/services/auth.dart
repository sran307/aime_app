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
  await newData.encrypt(deviceData);
  try {
    final Response = await http.post(Uri.parse(checkExistUrl),
        headers: {'Accept': 'appication/json'},
        body: {'deviceData': deviceData});
    print(Response);
    apiResponse.data = {'success': 'true'};
  } catch (e) {
    apiResponse.error = smw;
  }
  return false;
}
