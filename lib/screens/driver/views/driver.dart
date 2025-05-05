import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_management_app_2/screens/driver/controllers/driver_controller.dart';
import 'package:travel_management_app_2/screens/driver/models/journey.dart';
import 'package:travel_management_app_2/screens/driver/views/create_journey/create_journey.dart';
import 'package:travel_management_app_2/screens/driver/views/my_journey/my_journey.dart';

class Driver extends StatefulWidget {
  final String role;
  final String userId;
  final Journey? journey;
  final Position position;
  const Driver({
    super.key,
    required this.role,
    required this.userId,
    required this.position,
    this.journey,
  });

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  Journey? journey;

  Future<void> fetchData() async {
    final DriverController controller = DriverController();
    journey = await controller.getJourneyFromSupabase(widget.userId);
    log('Driver: ${JsonEncoder.withIndent(' ').convert(journey)}');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.map_outlined), text: 'Go on a trip'),
                  Tab(icon: Icon(Icons.drive_eta_rounded), text: 'My trips'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    CreateJourney(
                      userId: widget.userId,
                      position: widget.position,
                    ),
                    MyJourney(userId: widget.userId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
