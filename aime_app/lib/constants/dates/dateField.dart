import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
// For changing the language
import 'package:flutter_localization/flutter_localization.dart';

class dateTimeField extends StatelessWidget {
  final format = DateFormat("dd-MM-yyyy HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: const InputDecoration(
          labelText: 'Event Date & Time',
          hintText: 'Enter the date...',
        ),
        format: format,
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
