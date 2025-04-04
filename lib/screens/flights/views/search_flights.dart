import 'dart:developer';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/flights/views/available_flights.dart';

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
        _departureDateController.text = pickedDate.toString().substring(0, 10);
        log(pickedDate.toString().substring(0, 10));
      });
    }
  }

  void search() {
    log(
      '${constants.returnAirportCode(_destinationController.text)}\n${_departureDateController.text}\n${_adultsController.text}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AvailableFlights(
              origin: 'HRE',
              destination: constants.returnAirportCode(
                _destinationController.text,
              ),
              departureDate: _departureDateController.text,
              adults: int.parse(_adultsController.text),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Search Flights')),
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
                textInputType: TextInputType.text,
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
                textInputType: TextInputType.number,
                controller: _adultsController,
                hintText: 'Number of adults',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyButton(
                onTap: search,
                text: 'Search',
                color: Colors.blue.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
