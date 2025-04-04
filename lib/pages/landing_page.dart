import 'package:flutter/material.dart';
import 'package:travel_management_app_2/pages/home.dart';
import 'package:travel_management_app_2/screens/flights/views/available_flights.dart';
import 'package:travel_management_app_2/screens/flights/views/search_flights.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                  Tab(icon: Icon(Icons.home), text: 'Home'),
                  // Tab(
                  //   icon: Icon(Icons.airplanemode_active_sharp),
                  //   text: 'Available flights',
                  // ),
                  Tab(icon: Icon(Icons.search), text: 'Look for a flight'),
                ],
              ),
              Expanded(
                child: TabBarView(children: [HomePage(), SearchFlights()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
