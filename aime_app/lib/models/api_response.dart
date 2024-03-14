import 'dart:convert';

class ApiResponse {
  Future<String> errorData(response) async {
    String errorMessage = '';
    try {
      // Try to parse response body as JSON
      final jsonData = jsonDecode(response.body);
      // Loop through the keys and take the first one as error message
      jsonData.forEach((key, value) {
        errorMessage = value.toString();
        return;
      });
      return errorMessage;
    } catch (e) {
      // If parsing as JSON fails, use status code as error message
      errorMessage = 'Failed to load data: ${response.statusCode}';
      return errorMessage;
    }
  }
}
