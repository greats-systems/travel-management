import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color color;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
