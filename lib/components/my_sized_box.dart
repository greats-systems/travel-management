import 'package:flutter/material.dart';

class MySizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const MySizedBox({super.key, this.height = 20, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width, child: child);
  }
}
