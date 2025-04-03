import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400)),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}
