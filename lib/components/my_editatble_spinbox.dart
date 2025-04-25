import 'package:flutter/material.dart';

class MyEditableSpinBox extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final String hintText;
  final double min;
  final double max;

  const MyEditableSpinBox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.hintText = '',
    this.min = 0,
    this.max = 100,
  }) : super(key: key);

  @override
  _MyEditableSpinBoxState createState() => _MyEditableSpinBoxState();
}

class _MyEditableSpinBoxState extends State<MyEditableSpinBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValue(double newValue) {
    // Clamp value within min/max range
    final clampedValue = newValue.clamp(widget.min, widget.max);
    widget.onChanged(clampedValue);
    _controller.text = clampedValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Decrement Button
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => _updateValue(widget.value - 1),
        ),
        // Text Field for Manual Input
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
            onSubmitted: (value) {
              final parsedValue = double.tryParse(value) ?? widget.value;
              _updateValue(parsedValue);
            },
          ),
        ),
        // Increment Button
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _updateValue(widget.value + 1),
        ),
      ],
    );
  }
}
