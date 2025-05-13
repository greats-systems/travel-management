import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/views/itinerary/my_flight_itineraries.dart';
import 'package:travel_management_app_2/screens/parcels/views/itinerary/my_parcel_itineraries.dart';
import 'package:travel_management_app_2/screens/shuttles/views/itinerary/my_shuttle_itineraries.dart';

class MyItineraries extends StatefulWidget {
  final String userId;
  const MyItineraries({super.key, required this.userId});

  @override
  State<MyItineraries> createState() => _MyItinerariesState();
}

class _MyItinerariesState extends State<MyItineraries> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.airplanemode_active), text: 'Flights'),
                  Tab(icon: Icon(Icons.directions_bus), text: 'Shuttles'),
                  Tab(icon: Icon(Icons.local_shipping), text: 'Cargo'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    MyFlightItineraries(userId: widget.userId),
                    MyShuttleItineraries(userId: widget.userId),
                    MyParcelItineraries(userId: widget.userId),
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
