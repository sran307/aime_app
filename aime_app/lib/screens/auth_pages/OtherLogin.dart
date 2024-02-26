import 'package:flutter/material.dart';

class OtherLogin extends StatefulWidget {
  const OtherLogin({super.key});

  @override
  State<OtherLogin> createState() => _OtherLoginState();
}

class _OtherLoginState extends State<OtherLogin> {
  String _enteredPin = '';

  void _handlePinInput(String value) {
    setState(() {
      _enteredPin += value;
    });
  }

  void _authenticate() {
    // Validate the entered PIN against the expected value
    String expectedPin = '1234'; // Example expected PIN
    if (_enteredPin == expectedPin) {
      // PIN is correct, navigate to main screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // PIN is incorrect, display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect PIN. Please try again.'),
        ),
      );
      // Clear the entered PIN
      setState(() {
        _enteredPin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter PIN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the entered PIN (for visualization purposes)
            Text(
              '$_enteredPin',
              style: TextStyle(fontSize: 24),
            ),
            // PIN input buttons
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(
                9,
                (index) => ElevatedButton(
                  onPressed: () => _handlePinInput((index + 1).toString()),
                  child: Text((index + 1).toString()),
                ),
              )..addAll([
                  ElevatedButton(
                    onPressed: () => _handlePinInput('0'),
                    child: Text('0'),
                  ),
                  ElevatedButton(
                    onPressed: _enteredPin.isNotEmpty ? _authenticate : null,
                    child: Text('Enter'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_enteredPin.isNotEmpty) {
                        setState(() {
                          _enteredPin =
                              _enteredPin.substring(0, _enteredPin.length - 1);
                        });
                      }
                    },
                    child: Icon(Icons.backspace),
                  ),
                ]),
            ),
          ],
        ),
      ),
    );
  }
}
