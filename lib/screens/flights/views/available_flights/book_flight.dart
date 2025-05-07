import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
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
  final String userId;
  final Flight flight;
  final String origin;
  final String destination;
  final String departureDate;
  final String? returnDate;
  final int adults;

  const BookFlight({
    super.key,
    required this.userId,
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

  String _completePhoneNumber = '';
  String _countryCode = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passengers = List.generate(widget.adults, (index) => PassengerFormData());
  }

  void bookFlight() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    log(_completePhoneNumber.toString().substring(1, 4));
    setState(() => _isLoading = true);

    try {
      final passengerList =
          passengers
              .map(
                (formData) => Passenger(
                  dateOfBirth: formData.dobController.text,
                  firstName: formData.firstNameController.text,
                  lastName: formData.lastNameController.text,
                  gender: formData.selectedGender!,
                  phoneNumber: _completePhoneNumber,
                  email: formData.emailController.text,
                ),
              )
              .toList();

      await controller.bookFlight(
        userId: widget.userId,
        origin: widget.origin,
        destination: widget.destination,
        departureDate: widget.departureDate,
        returnDate: widget.returnDate,
        adults: widget.adults,
        passengers: passengerList,
        flight: widget.flight,
        callingCode: _countryCode,
      );

      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e, s) {
      if (!mounted) return;
      if (e is DioException && e.response?.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.response.toString()),
            backgroundColor: Colors.orange,
          ),
        );
      } else {
        log('${e.toString()}, ${s.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter first name';
            }
            return null;
          },
        ),
        MySizedBox(),
        MyTextField(
          controller: formData.lastNameController,
          hintText: 'Last name',
          obscureText: false,
          textInputType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter last name';
            }
            return null;
          },
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
          validator: (value) {
            if (value == null) {
              return 'Please select gender';
            }
            return null;
          },
        ),
        MySizedBox(),
        IntlPhoneField(
          controller: formData.phoneNumberController,
          focusNode: formData.focusNode,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          initialCountryCode: 'ZW',
          validator: (phone) {
            if (phone == null || phone.number.isEmpty) {
              return 'Please enter phone number';
            }
            return null;
          },
          onChanged: (PhoneNumber phone) {
            _completePhoneNumber = phone.completeNumber;
            _countryCode = phone.countryCode;
            log(_countryCode.substring(1));
            log('Complete phone number: $_completePhoneNumber');
          },
          onCountryChanged: (country) {
            log('Country changed to ${country.name}');
          },
        ),
        MySizedBox(),
        MyTextField(
          controller: formData.emailController,
          hintText: 'Email',
          obscureText: false,
          textInputType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 5,
              left: MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
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
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MyButton(
                        onTap: bookFlight,
                        text: 'Book',
                        color: Colors.blue.shade400,
                      ),
                ],
              ),
            ),
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
  final FocusNode focusNode = FocusNode();
  String? selectedGender;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
}
