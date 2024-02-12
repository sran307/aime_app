import 'package:dailyme/models/api_response.dart';
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
    print(loginUrl);
    final Response = await http
        .get(Uri.parse(loginUrl), headers: {'Accept': 'application/json'});
    print(Response);
    apiResponse.data = {'success': 'true'};
  } catch (e) {
    apiResponse.error = smw;
  }
  return 'true';
}
