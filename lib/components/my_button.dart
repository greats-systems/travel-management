import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color color;
  // final Widget child;

  // const MyButton({super.key, required this.onTap, required this.child});
  const MyButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     height: 50,
    //     // padding: const EdgeInsets.all(25),
    //     decoration: BoxDecoration(
    //         color: Colors.blue[700], borderRadius: BorderRadius.circular(15.0)),
    //     child: Center(
    //       child: Text(
    //         text,
    //         style: const TextStyle(color: Colors.white, fontSize: 18),
    //       ),
    //     ),
    //   ),
    // );
  }
}
