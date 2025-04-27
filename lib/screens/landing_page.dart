import 'package:flutter/material.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/screens/flights/views/search_flights.dart';
import 'package:travel_management_app_2/screens/my_itineraries.dart';
import 'package:travel_management_app_2/screens/parcels/views/ship_parcels.dart';
import 'package:travel_management_app_2/screens/shuttles/views/search_shuttles.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  String? email;
  String? userId;
  final AuthService _authService = AuthService();

  void _fetchData() {
    email = _authService.getCurrentUserEmail();
    userId = _authService.getCurrentUserID();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  final List<Widget> _pages = [
    const SearchFlights(),
    const SearchShuttles(),
    const ShipParcels(),
    const MyItineraries(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: Icon(Icons.person)),
        title: Text(email!),
        actions: [
          GestureDetector(
            child: Icon(Icons.logout),
            onTap: () => _authService.signOut(),
          ),
        ],
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
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'Flights',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Shuttles'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Cargo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.luggage),
            label: 'Itineraries',
          ),
        ],
        // Optional customization:
        showUnselectedLabels: true, // Always show labels
        type: BottomNavigationBarType.fixed, // For more than 3 items
      ),
    );
  }
}
