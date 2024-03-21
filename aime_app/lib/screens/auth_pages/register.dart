import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/services/TokenHandler.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        // physics: Bouncing
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/bg.jpg'),
                  radius: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add more email validation logic if needed
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter 4 digit login pin',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Pin';
                      } else if (value.length != 4) {
                        return 'Pin must be 4 digits';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Only digits are allowed';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, submit the data
                        TokenHandler tokenHandler = TokenHandler(context);

                        Map<String, dynamic> data = {
                          "first_name": _nameController.text,
                          "email": _emailController.text,
                          "password": _passwordController.text,
                          "username": _passwordController.text,
                        };
                        tokenHandler.submitForm(data);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
