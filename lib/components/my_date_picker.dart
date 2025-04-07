import 'dart:developer';

import 'package:flutter/material.dart';

class MyDatePicker extends StatelessWidget {
  // DateTime? pickedDate;
  String helpText;
  String labelText;
  String fieldLabelText;
  DateTime firstDate;
  DateTime lastDate;
  TextEditingController controller = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  MyDatePicker({
    super.key,
    // required this.pickedDate,
    required this.helpText,
    required this.fieldLabelText,
    required this.labelText,
    required this.controller,
    required this.firstDate,
    required this.lastDate,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: helpText,
      cancelText: 'Cancel',
      confirmText: 'OK',
      fieldHintText: 'Month/Day/Year',
      fieldLabelText: fieldLabelText,
    );

    if (pickedDate != null) {
      log('my_date_picker pickedDate: $pickedDate');
      _selectedDate = pickedDate;
      log(_selectedDate.toString());
      controller.text = pickedDate.toString().substring(0, 10);
      log(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today),
        suffixIcon: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _selectDate(context),
        ),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }
}
