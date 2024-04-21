import 'package:flutter/material.dart';
import 'package:dailyme/constants/dates/dateField.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:dailyme/services/urls.dart';
import 'package:dailyme/constants/constants.dart';

class TodoForm extends StatefulWidget {
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String _selectedOption = 'Irregular';
  final List<String> _options = ['Irregular', 'Regular'];

  @override
  Widget build(BuildContext context) {
    return Form(
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
              padding: const EdgeInsets.all(3.0),
              child: dateTimeField(_dateController),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.only(left: 45.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:Colors.black,
                    width:1.0
                  ),
                  borderRadius: BorderRadius.circular(50.0)
    
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    focusColor: Colors.transparent,
                    value: _selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue!;
                      });
                    },
                    items: _options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value)
                      );
                    }).toList(),
                  ),
                ),
              ),
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
                      "option": _selectedOption,
                    };
    
                    TokenHandler tokenHandler = TokenHandler(context);
                    tokenHandler.submitCommonForm(data, todoSave);
                    _nameController.clear();
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
