import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/controllers/flight_controller.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
import 'package:travel_management_app_2/screens/flights/widgets/booked_flights_list_tile.dart';

class MyFlightItineraries extends StatefulWidget {
  final String userId;
  const MyFlightItineraries({super.key, required this.userId});

  @override
  State<MyFlightItineraries> createState() => _MyFlightItinerariesState();
}

class _MyFlightItinerariesState extends State<MyFlightItineraries> {
  List<FlightBooking>? _flightBookings = [];
  bool _isLoading = true;
  final FlightController flightController = FlightController();

  Future<void> _fetchData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final bookings = await flightController.getBookingsFromSupabase(
        widget.userId,
      );
      if (mounted) {
        setState(() {
          _flightBookings = bookings;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching bookings: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _flightBookings = null;
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
      child:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _flightBookings == null || _flightBookings!.isEmpty
              ? const Center(child: Text('No itineraries yet'))
              : BookedFlightsListTile(
                flightBookings: _flightBookings!,
                id: widget.userId,
              ),
    );
  }
}
