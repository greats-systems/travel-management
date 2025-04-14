import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/views/search_flights.dart';
import 'package:travel_management_app_2/screens/home/home.dart';
import 'package:travel_management_app_2/screens/my_itineraries.dart';
import 'package:travel_management_app_2/screens/shuttles/views/search_shuttles.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchFlights(),
    const SearchShuttles(),
    const MyItineraries(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person),
        title: Text('Travel Management App'),
      ),
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'Search Flights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.train),
            label: 'Search Shuttles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.luggage),
            label: 'My Itineraries',
          ),
        ],
        // Optional customization:
        showUnselectedLabels: true, // Always show labels
        type: BottomNavigationBarType.fixed, // For more than 3 items
      ),
    );
  }
}
