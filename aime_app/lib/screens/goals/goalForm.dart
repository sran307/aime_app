import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:dailyme/services/urls.dart';
import 'package:flutter/material.dart';

class GoalForm extends StatefulWidget {
  const GoalForm({super.key});

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
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
                  'Enter the goal',
                  style: formHeading,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Goal', hintText: 'Enter the goal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the goal';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter the amount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the amount';
                  }
                  return null;
                },
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              if(_formKey.currentState!.validate()){
                Map<String, dynamic> data={
                  "name": _nameController.text,
                  "amount": _amountController.text
                };
                TokenHandler tokenHandler =TokenHandler(context);
                tokenHandler.submitCommonForm(data, goalSave);
                _nameController.clear();
                _amountController.clear();
              }
            }, child: const Text('Add'),),)
          ],
        ),
      ),
    );
  }
}
