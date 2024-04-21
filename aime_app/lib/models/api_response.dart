import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dailyme/constants/flashMessage.dart';


class ApiResponse {
  Future<void> errorData(BuildContext context, response) async {
    String errorMessage = '';
    try {
      // Try to parse response body as JSON
      final jsonData = jsonDecode(response.body);
      // Loop through the keys and take the first one as error message
      jsonData.forEach((key, value) {
        errorMessage = value.toString();
        return;
      });
    } catch (e) {
      // If parsing as JSON fails, use status code as error message
      errorMessage = 'Failed to load data: ${response.statusCode}';
    }

    // _showErrorDialog(context, errorMessage);
    FlashMessage.showMessage(context, errorMessage, 400);
    Navigator.of(context).pop();
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
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
