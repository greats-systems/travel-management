import 'package:flutter/material.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/screens/flights/views/itinerary/my_flight_itineraries.dart';
import 'package:travel_management_app_2/screens/shuttles/views/itinerary/my_shuttle_itineraries.dart';

class MyItineraries extends StatefulWidget {
  const MyItineraries({super.key});

  @override
  State<MyItineraries> createState() => _MyItinerariesState();
}

class _MyItinerariesState extends State<MyItineraries> {
  AuthService authService = AuthService();
  String? userId;

  void fetchUserID() {
    userId = authService.getCurrentUserID();
  }

  @override
  void initState() {
    super.initState();
    fetchUserID();
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
                  Tab(icon: Icon(Icons.airplanemode_active), text: 'Flights'),
                  Tab(icon: Icon(Icons.directions_bus), text: 'Shuttles'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    MyFlightItineraries(userId: userId!),
                    MyShuttleItineraries(userId: userId!),
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
