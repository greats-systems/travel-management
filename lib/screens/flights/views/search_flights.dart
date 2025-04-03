import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';

class SearchFlights extends StatefulWidget {
  const SearchFlights({super.key});

  @override
  State<SearchFlights> createState() => _SearchFlightsState();
}

class _SearchFlightsState extends State<SearchFlights> {
  final _destinationController = TextEditingController();
  final _departureDateController = TextEditingController();
  final _adultsController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      helpText: 'Departure date',
      cancelText: 'Cancel',
      confirmText: 'OK',
      fieldHintText: 'Month/Day/Year',
      fieldLabelText: 'Select departure date',
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _departureDateController.text = pickedDate.toString();
        log(pickedDate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Flights')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 2,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: ListView(
            children: [
              MyTextField(
                controller: _destinationController,
                hintText: 'Destination',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _departureDateController,
                decoration: InputDecoration(
                  labelText: 'Departure Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _adultsController,
                hintText: 'Number of adults',
                obscureText: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
