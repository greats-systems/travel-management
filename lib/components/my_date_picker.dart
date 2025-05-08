import 'package:flutter/material.dart';

class MyDatePicker extends StatelessWidget {
  final String helpText;
  final String labelText;
  final String fieldLabelText;
  final DateTime firstDate;
  final DateTime lastDate;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final DateTime? initialDate;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool showClearButton;

  const MyDatePicker({
    super.key,
    required this.helpText,
    required this.fieldLabelText,
    required this.labelText,
    required this.controller,
    required this.firstDate,
    required this.lastDate,
    this.validator,
    this.initialDate,
    this.decoration,
    this.style,
    this.showClearButton = false,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: helpText,
      cancelText: 'Cancel',
      confirmText: 'OK',
      fieldHintText: 'Month/Day/Year',
      fieldLabelText: fieldLabelText,
    );

    if (pickedDate != null && pickedDate != initialDate) {
      controller.text = _formatDate(pickedDate);
      if (validator != null) {
        validator!(controller.text);
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _clearDate() {
    controller.clear();
    if (validator != null) {
      validator!(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: (decoration ?? InputDecoration()).copyWith(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        prefixIcon: const Icon(Icons.calendar_today),
        suffixIcon:
            showClearButton && controller.text.isNotEmpty
                ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearDate,
                )
                : IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _selectDate(context),
                ),
      ),
      style: style,
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: validator,
    );
  }
}
