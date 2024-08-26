import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
// For changing the language

class ValidityField extends StatelessWidget {
  final format = DateFormat("dd-MM-yyyy HH:mm");

  TextEditingController dateController;

  ValidityField(this.dateController);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: dateController,
        decoration: const InputDecoration(
          labelText: 'Validity',
          hintText: 'Enter the date...',
        ),
        format: format,
        // validator: (value) {
        //   if (value == null) {
        //     return 'Enter a date and time';
        //   }
        //   return null;
        // },
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          ).then((DateTime? date) async {
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          });
        },
      ),
    ]);
  }
}
