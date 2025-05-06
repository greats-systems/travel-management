// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// MyDatePicker updated version
class MyDatePicker extends StatelessWidget {
  final String helpText;
  final String labelText;
  final String fieldLabelText;
  final DateTime firstDate;
  final DateTime lastDate;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  DateTime _selectedDate = DateTime.now();

  MyDatePicker({
    super.key,
    required this.helpText,
    required this.fieldLabelText,
    required this.labelText,
    required this.controller,
    required this.firstDate,
    required this.lastDate,
    this.validator,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      currentDate: _selectedDate,
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
      _selectedDate = pickedDate;
      controller.text = pickedDate.toString().substring(0, 10);
      if (validator != null) {
        validator!(controller.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        prefixIcon: Icon(Icons.calendar_today),
        suffixIcon: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _selectDate(context),
        ),
        errorText: validator != null ? validator!(controller.text) : null,
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: validator,
    );
  }
}
