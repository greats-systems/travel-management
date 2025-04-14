import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_booking.dart';
import 'package:travel_management_app_2/screens/shuttles/widgets/booked_shuttles_list_tile.dart';

class MyShuttleItineraries extends StatefulWidget {
  final String userId;
  const MyShuttleItineraries({super.key, required this.userId});

  @override
  State<MyShuttleItineraries> createState() => _MyShuttleItinerariesState();
}

class _MyShuttleItinerariesState extends State<MyShuttleItineraries> {
  List<ShuttleBooking>? _shuttleBookings = [];
  bool _isLoading = true;
  final ShuttleController _shuttleController = ShuttleController();

  Future<void> _fetchData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final bookings = await _shuttleController.getBookingsFromSupabase(
        widget.userId,
      );
      if (mounted) {
        setState(() {
          _shuttleBookings = bookings;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching bookings: $e');
      if (mounted) {
        _isLoading = false;
        _shuttleBookings = null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _shuttleBookings == null || _shuttleBookings!.isEmpty
              ? const Center(child: Text('No itineraries yet'))
              : BookedShuttlesListTile(
                shuttleBookings: _shuttleBookings,
                userId: widget.userId,
              ),
    );
  }
}
