import 'package:flutter/material.dart';

class MySizedBox extends StatelessWidget {
  double? width;
  double? height;
  MySizedBox({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return height == null && width == null
        ? SizedBox(height: 20)
        : SizedBox(height: height);
  }
}
