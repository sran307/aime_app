import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';

class LockerForm extends StatefulWidget {
  const LockerForm({super.key});

  @override
  State<LockerForm> createState() => _LockerFormState();
}

class _LockerFormState extends State<LockerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

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
                  const Text(
                    'Enter The Item',
                    style: formHeading,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 1.0),
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
                padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 1.0),
                child: TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Item Description',
                    hintText: 'Enter the description...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the descritption';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                child: TextFormField(
                  controller: _keyController,
                  decoration: const InputDecoration(
                    labelText: 'Secret Key',
                    hintText: 'Enter the secret key...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter secret key';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        "desc": _descController.text,
                        "name": _nameController.text,
                        "key": _keyController.text
                      };

                      // TokenHandler tokenHandler = TokenHandler(context);
                      // tokenHandler.submitCommonForm(data, todoSave);
                      _nameController.clear();
                      _descController.clear();
                      _nameController.clear();
                      _keyController.clear();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          ),
        ));
  }
}
