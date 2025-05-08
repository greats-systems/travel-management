import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/views/available_shuttles/buses/available_shuttle_services.dart';
import 'package:travel_management_app_2/screens/shuttles/views/available_shuttles/rides/available_rides.dart';

class AvailableShuttlesLandingPage extends StatefulWidget {
  final String userId;
  final String origin;
  final String destination;
  final String departureDate;
  const AvailableShuttlesLandingPage({
    super.key,
    required this.userId,
    required this.origin,
    required this.destination,
    required this.departureDate,
  });

  @override
  State<AvailableShuttlesLandingPage> createState() =>
      _AvailableShuttlesLandingPageState();
}

class _AvailableShuttlesLandingPageState
    extends State<AvailableShuttlesLandingPage> {
  late List<Widget> _pages;
  late List<BottomNavigationBarItem> _navItems;
  int _currentIndex = 0;
  bool _isLoading = true;

  void _buildPagesAndNavItems() {
    // Common pages for all users
    _pages = [
      AvailableShuttleServices(
        userId: widget.userId,
        origin: widget.origin,
        destination: widget.destination,
        departureDate: widget.departureDate,
      ),
      AvailableRides(
        userId: widget.userId,
        origin: widget.origin,
        destination: widget.destination,
      ),
    ];

    // Common navigation items
    _navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.directions_bus),
        label: 'Buses',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.drive_eta),
        label: 'Rides',
      ),
    ];
  }

  Future<void> _initializeApp() async {
    _buildPagesAndNavItems();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
