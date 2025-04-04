import 'dart:developer';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_list_tile.dart';
// import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/flights/controllers/flight_controller.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';

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
  List<Flight>? _flights = [];
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final flights = await flightController.searchForMorePrices(
        widget.destination,
        widget.departureDate,
        widget.returnDate,
        widget.adults,
      );
      if (mounted) {
        setState(() {
          _flights = flights;
          _isloading = false;
        });
      }
    } catch (e) {
      log('Error on initialization $e');
      if (mounted) setState(() => _isloading = false);
    }
  }

  Widget _buildBody() {
    return _isloading != true
        ? SafeArea(child: MyListTile(flights: _flights))
        : Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${constants.returnLocation(widget.origin)} \u2192 ${constants.returnLocation(widget.destination)}',
        ),
        actions: [IconButton(onPressed: _fetchData, icon: Icon(Icons.refresh))],
      ),
      body: _buildBody(),
    );
  }
}
