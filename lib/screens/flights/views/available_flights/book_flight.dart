import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_dropdown.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_snack_bar.dart';
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
  final FlightController _controller = FlightController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late List<PassengerFormData> _passengers;
  bool _isLoading = false;
  String _completePhoneNumber = '';
  String _countryCode = '';

  @override
  void initState() {
    super.initState();
    _passengers = List.generate(widget.adults, (index) => PassengerFormData());
  }

  @override
  void dispose() {
    for (final passenger in _passengers) {
      passenger.dispose();
    }
    super.dispose();
  }

  Future<void> _bookFlight() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final passengerList = _passengers.map(_mapFormDataToPassenger).toList();

      await _controller.bookFlight(
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

      MySnackBar.showSnackBar(
        context,
        'Flight booking successful!',
        Colors.green,
      );
      Navigator.pop(context);
    } on DioException catch (e) {
      if (!mounted) return;
      _handleDioError(e);
    } catch (e, stackTrace) {
      if (!mounted) return;
      _handleGenericError(e, stackTrace);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Passenger _mapFormDataToPassenger(PassengerFormData formData) {
    return Passenger(
      dateOfBirth: formData.dobController.text,
      firstName: formData.firstNameController.text,
      lastName: formData.lastNameController.text,
      gender: formData.selectedGender!,
      phoneNumber: _completePhoneNumber,
      email: formData.emailController.text,
    );
  }

  void _handleDioError(DioException e) {
    if (e.response?.statusCode == 404) {
      MySnackBar.showSnackBar(context, 'Flight not found', Colors.orange);
    } else {
      MySnackBar.showSnackBar(
        context,
        'Network error: ${e.message}',
        Colors.red,
      );
    }
  }

  void _handleGenericError(Object e, StackTrace stackTrace) {
    log('Booking error', error: e, stackTrace: stackTrace);
    MySnackBar.showSnackBar(
      context,
      'An error occurred. Please try again.',
      Colors.red,
    );
  }

  Widget _buildPassengerForm(int index) {
    final formData = _passengers[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.adults > 1) _buildPassengerHeader(index),
        MyDatePicker(
          helpText: 'Date of birth',
          fieldLabelText: 'Date of birth',
          labelText: 'Date of birth',
          controller: formData.dobController,
          firstDate: DateTime(DateTime.now().year - 60),
          lastDate: DateTime.now(),
        ),
        const MySizedBox(),
        _buildNameField(
          controller: formData.firstNameController,
          label: 'First name',
        ),
        const MySizedBox(),
        _buildNameField(
          controller: formData.lastNameController,
          label: 'Last name',
        ),
        const MySizedBox(),
        _buildGenderDropdown(formData),
        const MySizedBox(),
        _buildPhoneField(formData),
        const MySizedBox(),
        _buildEmailField(formData),
        if (index < widget.adults - 1) const Divider(thickness: 2),
      ],
    );
  }

  Widget _buildPassengerHeader(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        'Passenger ${index + 1}',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildNameField({
    required TextEditingController controller,
    required String label,
  }) {
    return MyTextField(
      controller: controller,
      hintText: label,
      validator:
          (value) => value?.isEmpty ?? true ? 'Please enter $label' : null,
    );
  }

  Widget _buildGenderDropdown(PassengerFormData formData) {
    return MyDropdown(
      label: 'Gender',
      value: formData.selectedGender,
      items: const [
        DropdownMenuItem(value: 'Male', child: Text('Male')),
        DropdownMenuItem(value: 'Female', child: Text('Female')),
      ],
      onChanged: (value) => setState(() => formData.selectedGender = value),
      prefixIcon: Icons.person,
      isRequired: true,
      validator: (value) => value == null ? 'Please select gender' : null,
    );
  }

  Widget _buildPhoneField(PassengerFormData formData) {
    return IntlPhoneField(
      controller: formData.phoneNumberController,
      focusNode: formData.focusNode,
      initialCountryCode: 'ZW',
      validator:
          (phone) =>
              phone == null || phone.number.isEmpty
                  ? 'Please enter phone number'
                  : null,
      onChanged: (PhoneNumber phone) {
        _completePhoneNumber = phone.completeNumber;
        _countryCode = phone.countryCode;
      },
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }

  Widget _buildEmailField(PassengerFormData formData) {
    return MyTextField(
      controller: formData.emailController,
      hintText: 'Email',
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter email';
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width / 10;
    final topPadding = MediaQuery.of(context).size.width / 5;

    return Scaffold(
      appBar: AppBar(title: Text('Book a flight')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding,
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Book flight',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const MySizedBox(),
                  ...List.generate(widget.adults, _buildPassengerForm),
                  const MySizedBox(),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : MyButton(
                        onTap: _bookFlight,
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
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String? selectedGender;

  void dispose() {
    dobController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    focusNode.dispose();
  }
}
