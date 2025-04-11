import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class MyPhoneNumberField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? initialCountryCode;
  final String? labelText;
  final TextEditingController? controller;

  const MyPhoneNumberField({
    super.key,
    this.onChanged,
    this.initialCountryCode = 'US',
    this.labelText = 'Phone Number',
    this.controller,
  });

  @override
  State<MyPhoneNumberField> createState() => _MyPhoneNumberFieldState();
}

class _MyPhoneNumberFieldState extends State<MyPhoneNumberField> {
  late final TextEditingController _controller;
  String _completeNumber = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Only dispose if we created it
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      initialCountryCode: widget.initialCountryCode,
      onChanged: (PhoneNumber phone) {
        _completeNumber = phone.completeNumber;
        widget.onChanged?.call(_completeNumber);
      },
      onCountryChanged: (country) {
        debugPrint('Country changed to ${country.name}');
      },
    );
  }
}
