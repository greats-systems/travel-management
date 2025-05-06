import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/ride_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/ride.dart';
import 'package:travel_management_app_2/screens/shuttles/widgets/available_rides_map.dart';

class AvailableRides extends StatefulWidget {
  final String userId;
  final String origin;
  final String destination;
  const AvailableRides({
    super.key,
    required this.userId,
    required this.origin,
    required this.destination,
  });

  @override
  State<AvailableRides> createState() => _AvailableRidesState();
}

class _AvailableRidesState extends State<AvailableRides> {
  bool _isLoading = false;
  List<Ride> _rides = [];
  String? _error;
  final RideController _rideController = RideController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final rides = await _rideController.getRides(
        widget.origin,
        widget.destination,
      );

      if (!mounted) return;

      setState(() {
        _rides = rides;
        _isLoading = false;
      });

      log('Fetched ${_rides.length} rides');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _error = 'Failed to load rides';
      });

      log('Error fetching rides: $e');
    }
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!));
    }

    if (_rides.isEmpty) {
      return const Center(child: Text('No rides available at this time'));
    }

    return AvailableRidesMap(rides: _rides, userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Rides')),
      body: _buildBody(),
    );
  }
}
