import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_booking.dart';

class BookShuttle extends StatefulWidget {
  final String? companyId;
  final String? routeId;
  final String? userId;
  final String? origin;
  final String? destination;
  final String? departureDate;
  final double amountPaid;
  const BookShuttle({
    super.key,
    required this.companyId,
    required this.routeId,
    required this.userId,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.amountPaid,
  });

  @override
  State<BookShuttle> createState() => _BookShuttleState();
}

class _BookShuttleState extends State<BookShuttle> {
  bool _isLoading = false;
  final ShuttleController _shuttleController = ShuttleController();
  FocusNode focusNode = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String _completePhoneNumber = '';
  final TextEditingController _emailController = TextEditingController();
  final ShuttleBooking _shuttleBooking = ShuttleBooking();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void bookShuttle() async {
    setState(() {
      _isLoading = true;
    });
    _shuttleBooking.userID = widget.userId;
    _shuttleBooking.companyID = widget.companyId;
    _shuttleBooking.routeID = widget.routeId;
    _shuttleBooking.firstName = _firstNameController.text;
    _shuttleBooking.lastName = _lastNameController.text;
    _shuttleBooking.email = _emailController.text;
    _shuttleBooking.phoneNumber = _completePhoneNumber;
    _shuttleBooking.origin = widget.origin;
    _shuttleBooking.destination = widget.destination;
    _shuttleBooking.departureDate = widget.departureDate;
    _shuttleBooking.amountPaid = widget.amountPaid;

    try {
      await _shuttleController.bookShuttle(_shuttleBooking);
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
    } catch (e) {
      if (!mounted) return;
      if (e is DioException && e.response?.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.response.toString()),
            backgroundColor: Colors.red,
          ),
        );
      } else {
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

  Widget buildPassengerForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        IntlPhoneField(
          controller: _phoneNumberController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            labelText: 'Phone number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          initialCountryCode: 'ZW',
          onChanged: (PhoneNumber phoneNumber) {
            _completePhoneNumber = phoneNumber.completeNumber;
          },
        ),
        MySizedBox(),
        MyTextField(
          controller: _emailController,
          hintText: 'Email',
          obscureText: false,
          textInputType: TextInputType.text,
        ),
        MySizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book shuttle')),
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
                child: Text(
                  'Book shuttle',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              MySizedBox(),
              buildPassengerForm(),
              MySizedBox(),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : MyButton(
                    onTap: bookShuttle,
                    text: 'Book',
                    color: Colors.blue.shade300,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
