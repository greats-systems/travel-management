import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_booking.dart';

class BookShuttle extends StatefulWidget {
  final String companyId;
  final String companyName;
  final String routeId;
  final String userId;
  final String origin;
  final String destination;
  final String departureDate;
  final String departureTime;
  final String arrivalTime;
  final double amountPaid;

  const BookShuttle({
    super.key,
    required this.companyId,
    required this.companyName,
    required this.routeId,
    required this.userId,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalTime,
    required this.amountPaid,
  });

  @override
  State<BookShuttle> createState() => _BookShuttleState();
}

class _BookShuttleState extends State<BookShuttle> {
  final ShuttleController _shuttleController = ShuttleController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Text controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _completePhoneNumber = '';

  // Focus nodes
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  Future<void> _bookShuttle() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final booking =
        ShuttleBooking()
          ..userID = widget.userId
          ..companyID = widget.companyId
          ..routeID = widget.routeId
          ..firstName = _firstNameController.text.trim()
          ..lastName = _lastNameController.text.trim()
          ..email = _emailController.text.trim()
          ..phoneNumber = _completePhoneNumber
          ..origin = widget.origin
          ..destination = widget.destination
          ..departureDate = widget.departureDate
          ..departureTime = widget.departureTime
          ..arrivalTime = widget.arrivalTime
          ..amountPaid = widget.amountPaid
          ..companyName = widget.companyName;

    try {
      await _shuttleController.bookShuttle(booking);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.popAndPushNamed(context, '/landing-page');
    } on DioException catch (e) {
      if (!mounted) return;

      final errorMessage =
          e.response?.statusCode == 404
              ? 'Service not available'
              : 'Error: ${e.message}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred'),
          backgroundColor: Colors.red,
        ),
      );
      log('Booking error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildPassengerForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextField(
            controller: _firstNameController,
            hintText: 'First name',
            obscureText: false,
            textInputType: TextInputType.name,
          ),
          MySizedBox(),
          MyTextField(
            controller: _lastNameController,
            hintText: 'Last name',
            obscureText: false,
            textInputType: TextInputType.name,
          ),
          MySizedBox(),
          IntlPhoneField(
            initialCountryCode: 'ZW',
            onChanged: (PhoneNumber phoneNumber) {
              _completePhoneNumber = phoneNumber.completeNumber;
            },
            controller: _phoneNumberController,
            focusNode: _phoneFocusNode,
            decoration: const InputDecoration(
              labelText: 'Phone number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          MySizedBox(),
          MyTextField(
            controller: _emailController,
            hintText: 'Email',
            obscureText: false,
            textInputType: TextInputType.emailAddress,
          ),
          MySizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width / 10;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Shuttle')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 5,
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  'Book Shuttle',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              MySizedBox(),
              _buildPassengerForm(),
              MySizedBox(height: 15),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MyButton(
                    onTap: _bookShuttle,
                    text: 'Pay',
                    color: Colors.green.shade300,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
