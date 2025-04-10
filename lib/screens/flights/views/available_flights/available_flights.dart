import 'dart:developer';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_list_tile.dart';
import 'package:travel_management_app_2/screens/flights/controllers/flight_controller.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/screens/flights/widgets/avalable_flights_list_tile.dart';

class AvailableFlights extends StatefulWidget {
  final String origin;
  final String destination;
  final String departureDate;
  final String? returnDate;
  final int adults;

  const AvailableFlights({
    super.key,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.returnDate,
    required this.adults,
  });

  @override
  State<AvailableFlights> createState() => _AvailableFlightsState();
}

class _AvailableFlightsState extends State<AvailableFlights> {
  final FlightController flightController = FlightController();
  List<Flight>? _flights;
  bool _isLoading = true; // Start with true to show loading initially

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchData() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }

    try {
      final flights = await flightController.getFlightPrices(
        widget.origin,
        widget.destination,
        widget.departureDate,
        widget.returnDate,
        widget.adults,
      );

      if (mounted) {
        setState(() {
          _flights = flights;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching flights: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _flights = null; // Clear previous data on error
        });
      }
    }
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_flights == null || _flights!.isEmpty) {
      return const Center(child: Text('No flights available'));
    }

    return SafeArea(
      child: AvailableFlightsListTile(
        flights: _flights!,
        origin: widget.origin,
        destination: widget.destination,
        departureDate: widget.departureDate,
        returnDate: widget.returnDate,
        adults: widget.adults,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${constants.returnLocation(widget.origin)} \u2192 ${constants.returnLocation(widget.destination)}',
        ),
        // actions: [
        //   IconButton(onPressed: _fetchData, icon: const Icon(Icons.refresh)),
        // ],
      ),
      body: _buildBody(),
    );
  }
}
