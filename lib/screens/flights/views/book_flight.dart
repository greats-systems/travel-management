import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_dropdown.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/flights/controllers/flight_controller.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';

class BookFlight extends StatefulWidget {
  final Flight flight;
  final String origin;
  final String destination;
  final String departureDate;
  final String? returnDate;
  final int adults;

  const BookFlight({
    super.key,
    required this.flight,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.returnDate,
    required this.adults,
  });

  @override
  State<BookFlight> createState() => _BookFlightState();
}

class _BookFlightState extends State<BookFlight> {
  final controller = FlightController();
  final _dobController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  // final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? selectedGender;

  void bookFlight() {
    log('Passing flight info to controller');
    controller.bookFlight(
      widget.origin,
      widget.destination,
      widget.departureDate,
      widget.returnDate,
      widget.adults,
      _dobController.text,
      _firstNameController.text,
      _lastNameController.text,
      selectedGender!,
      _phoneNumberController.text,
      _emailController.text,
      widget.flight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book a flight')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 2,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: ListView(
            children: [
              Center(
                child: Text('Book flight', style: TextStyle(fontSize: 24)),
              ),
              SizedBox(height: 20),

              // passenger details
              MyDatePicker(
                helpText: 'Date of birth',
                fieldLabelText: 'Date of birth',
                labelText: 'Date of birth',
                controller: _dobController,
                firstDate: DateTime(DateTime.now().year - 60),
                lastDate: DateTime.now(),
              ),
              SizedBox(height: 50),
              MyTextField(
                controller: _firstNameController,
                hintText: 'First name',
                obscureText: false,
                textInputType: TextInputType.text,
              ),
              MySizedBox(),
              MyTextField(
                controller: _lastNameController,
                hintText: 'Last name',
                obscureText: false,
                textInputType: TextInputType.text,
              ),
              MySizedBox(),
              MyDropdown(
                label: 'Gender',
                value: selectedGender,
                items: [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                ],
                onChanged: (value) => setState(() => selectedGender = value),
                prefixIcon: Icons.person,
                isRequired: true,
              ),
              MySizedBox(height: 20),
              MyTextField(
                controller: _phoneNumberController,
                hintText: 'Phone number',
                obscureText: false,
                textInputType: TextInputType.number,
              ),
              MySizedBox(),
              MyTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
                textInputType: TextInputType.emailAddress,
              ),
              MySizedBox(),
              MyButton(
                onTap: bookFlight,
                text: 'Book',
                color: Colors.blue.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
