import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  static const List<String> _merchantList = [
    'Food Lovers',
    'Spar',
    'OK',
    'Pick n Pay',
    'Choppies'
  ];
  static const Map<String, String> _merchants = {
    'Food Lovers': 'assets/merchants/food_lovers.png',
    'Spar': 'assets/merchants/spar.png',
    'OK': 'assets/merchants/ok.png',
    'Pick n Pay': 'assets/merchants/pnp.png',
    'Choppies': 'assets/merchants/choppies.webp',
  };
  String? _merchant;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      hint: Text('Merchant'),
      items: _merchantList.map((name) {
        return DropdownMenuItem(
          value: name,
          child: Row(
            children: [
              Image.asset(
                _merchants[name]!,
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(name),
            ],
          ),
        );
      }).toList(),
      value: _merchant,
      onChanged: (newValue) => setDropdownValue(newValue),
    );
  }

  String? getMerchant() {
    return _merchant;
  }

  void setDropdownValue(value) {
    setState(() {
      _merchant = value;
      print(_merchant);
    });
  }
}
