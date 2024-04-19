import 'package:flutter/material.dart';
import 'package:dailyme/constants/dates/dateField.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:dailyme/services/urls.dart';
import 'package:dailyme/constants/constants.dart';


class TodoForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   gradient: kSecondaryGradientColor,
      //   borderRadius: BorderRadius.circular(20.0),
      // ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Enter The Item', style: formHeading,),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    hintText: 'Enter the item...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the item';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
                child: dateTimeField(_dateController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String? dateTimeValue = _dateController.text;
                        Map<String, dynamic> data = {
                          "name": _nameController.text,
                          "date": dateTimeValue,
                        };
              
                        TokenHandler tokenHandler = TokenHandler(context);
                        tokenHandler.submitCommonForm(data, todoSave);
                        _nameController.clear();
                      }
                    },
                    child: Text('Add')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
