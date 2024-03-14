import 'package:dailyme/services/TokenHandler.dart';
import 'package:dailyme/services/deviceDetails.dart';
import 'package:flutter/material.dart';
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 51, 72, 80),
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Color.fromARGB(99, 100, 185, 200),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/bg.jpg'),
                        radius: 50.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 500.0,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Enter fullname',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Enter emailId',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!_isValidEmail(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Enter 4 digit login pin',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value.length != 4) {
                                    return 'Password must be 4 digits';
                                  } else if (!RegExp(r'^[0-9]+$')
                                      .hasMatch(value)) {
                                    return 'Only digits are allowed';
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing...')),
                              );
                              TokenHandler tokenHandler = TokenHandler(context);
                              
                              Map<String, dynamic> data = {
                                "first_name": _nameController.text,
                                "email": _emailController.text,
                                "password": _passwordController.text,
                                "username": _passwordController.text,
                              };
                              tokenHandler.submitForm(data);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter valid data')),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            color: const Color(0xFFC8C8C8), // Background color
            child: const Text(
              '© All rights reserved.',
              textAlign: TextAlign.center, // Center the text horizontally
              style: TextStyle(
                  fontSize: 12.0, // Font size
                  color: Colors.black87,
                  height: 4.0 // Text color
                  ),
            ),
          ),
        ],
      )),
    );
  }

  bool _isValidEmail(String email) {
    // Regular expression for validating email addresses
    // This expression checks for a standard email format.
    // It may not cover all possible valid email formats, but it provides basic validation.
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
