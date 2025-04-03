import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_list_tile.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/flights/controllers/flight_controller.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';

class AvailableFlights extends StatefulWidget {
  const AvailableFlights({super.key});

  @override
  State<AvailableFlights> createState() => _AvailableFlightsState();
}

class _AvailableFlightsState extends State<AvailableFlights> {
  // late Future<List<Flight>> _flights;
  final _searchController = TextEditingController();
  final FlightController flightController = FlightController();
  List<Flight>? _flights = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // const AirlineLogo({})

  Future<void> _fetchData() async {
    try {
      final flights = await flightController.getFlightPrices();
      setState(() {
        _flights = flights;
      });
    } catch (e) {
      log('Error on initialization $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Flights')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyTextField(
                controller: _searchController,
                hintText: 'Search for flights',
                obscureText: false,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: MyListTile(flights: _flights),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
