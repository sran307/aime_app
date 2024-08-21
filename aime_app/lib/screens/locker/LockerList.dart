import 'package:dailyme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LockerList extends StatefulWidget {
  const LockerList({super.key});

  @override
  State<LockerList> createState() => _LockerListState();
}

class _LockerListState extends State<LockerList> {
  final String _correctPassword =
      "password123"; // Change this to your desired password
  bool _isPasswordCorrect = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _keyController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  void _showPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Password'),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "Password"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                if (_passwordController.text == _correctPassword) {
                  setState(() {
                    _isPasswordCorrect = true;
                  });
                  Navigator.of(context).pop();
                } else {
                  // Show an error message or handle incorrect password
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Incorrect Password')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: bg1,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My Secret Items',
                style: formHeading,
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(96, 180, 39, 39),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _showPasswordDialog,
                    child: Text(
                      'Click here to enter password',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 4, 81, 143),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
