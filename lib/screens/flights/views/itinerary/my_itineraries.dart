// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/screens/flights/controllers/flight_controller.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
// import 'package:travel_management_app_2/screens/flights/widgets/avalable_flights_list_tile.dart';
import 'package:travel_management_app_2/screens/flights/widgets/booked_flights_list_tile.dart';

class MyItineraries extends StatefulWidget {
  const MyItineraries({super.key});

  @override
  State<MyItineraries> createState() => _MyItinerariesState();
}

class _MyItinerariesState extends State<MyItineraries> {
  List<Booking>? _bookings = [];
  String? userId;
  bool _isLoading = true;
  final FlightController flightController = FlightController();
  final AuthService authService = AuthService();

  Future<void> _fetchData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      userId = authService.getCurrentUserID();
      log('userId from MyItineraries: $userId');
      final bookings = await flightController.getBookingsFromSupabase(userId);
      if (mounted) {
        setState(() {
          _bookings = bookings;
          _isLoading = false;
          // log(
          //   '_bookings from MyItineraries: ${JsonEncoder.withIndent(' ').convert(_bookings)}',
          // );
        });
      }
    } catch (e) {
      log('Error fetching bookings: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          // _bookings = null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BookedFlightsListTile(bookings: _bookings!, id: userId!),
    );
  }
}
