import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_dropdown.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/flights/controllers/flight_controller.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/screens/flights/models/passenger.dart';

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
  bool _isLoading = false;
  final controller = FlightController();
  late List<PassengerFormData> passengers;
  final AuthService authService = AuthService();
  String? id;

  @override
  void initState() {
    super.initState();
    fetchID();
    // Initialize form data for each passenger
    passengers = List.generate(widget.adults, (index) => PassengerFormData());
  }

  void fetchID() {
    setState(() {
      id = authService.getCurrentUserID();
    });
  }

  void bookFlight() {
    log('Passing flight info to controller');
    setState(() => _isLoading = true);

    try {
      // Convert all passenger form data to Passenger objects
      final passengerList =
          passengers
              .map(
                (formData) => Passenger(
                  dateOfBirth: formData.dobController.text,
                  firstName: formData.firstNameController.text,
                  lastName: formData.lastNameController.text,
                  gender: formData.selectedGender!,
                  phoneNumber: formData.phoneNumberController.text,
                  email: formData.emailController.text,
                ),
              )
              .toList();

      controller.bookFlight(
        id!,
        widget.origin,
        widget.destination,
        widget.departureDate,
        widget.returnDate,
        widget.adults,
        passengerList,
        widget.flight,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget buildPassengerForm(int index) {
    final formData = passengers[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.adults > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Passenger ${index + 1}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        MyDatePicker(
          helpText: 'Date of birth',
          fieldLabelText: 'Date of birth',
          labelText: 'Date of birth',
          controller: formData.dobController,
          firstDate: DateTime(DateTime.now().year - 60),
          lastDate: DateTime.now(),
        ),
        MySizedBox(),
        MyTextField(
          controller: formData.firstNameController,
          hintText: 'First name',
          obscureText: false,
          textInputType: TextInputType.text,
        ),
        MySizedBox(),
        MyTextField(
          controller: formData.lastNameController,
          hintText: 'Last name',
          obscureText: false,
          textInputType: TextInputType.text,
        ),
        MySizedBox(),
        MyDropdown(
          label: 'Gender',
          value: formData.selectedGender,
          items: [
            DropdownMenuItem(value: 'Male', child: Text('Male')),
            DropdownMenuItem(value: 'Female', child: Text('Female')),
          ],
          onChanged: (value) => setState(() => formData.selectedGender = value),
          prefixIcon: Icons.person,
          isRequired: true,
        ),
        MySizedBox(),
        MyTextField(
          controller: formData.phoneNumberController,
          hintText: 'Phone number',
          obscureText: false,
          textInputType: TextInputType.number,
        ),
        MySizedBox(),
        MyTextField(
          controller: formData.emailController,
          hintText: 'Email',
          obscureText: false,
          textInputType: TextInputType.emailAddress,
        ),
        MySizedBox(),
        if (index < widget.adults - 1) Divider(thickness: 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book a flight')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 5,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: ListView(
            children: [
              Center(
                child: Text('Book flight', style: TextStyle(fontSize: 24)),
              ),
              MySizedBox(),
              ...List.generate(
                widget.adults,
                (index) => buildPassengerForm(index),
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

class PassengerFormData {
  final TextEditingController dobController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String? selectedGender;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
}
