import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/screens/driver/controllers/driver_controller.dart';
import 'package:travel_management_app_2/screens/driver/models/journey.dart';
import 'package:travel_management_app_2/screens/driver/views/driver.dart';
import 'package:travel_management_app_2/screens/flights/views/search_flights.dart';
import 'package:travel_management_app_2/screens/my_itineraries.dart';
import 'package:travel_management_app_2/screens/parcels/views/ship_parcel/parcel_logistics.dart';
// import 'package:travel_management_app_2/screens/parcels/views/ship_parcels.dart';
import 'package:travel_management_app_2/screens/shuttles/views/search_shuttles.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Journey? _journey;
  int _currentIndex = 0;
  String? email;
  String? userId;
  String? role;
  bool _isLoading = true;
  final AuthService _authService = AuthService();
  late List<Widget> _pages;
  late List<BottomNavigationBarItem> _navItems;
  Position? position;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    } else if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions have been denied permanently');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _initializeApp() async {
    position = await _determinePosition();
    log(position.toString());
    await _fetchData();
    _buildPagesAndNavItems();
    setState(() => _isLoading = false);
  }

  Future<void> _fetchData() async {
    final DriverController controller = DriverController();
    email = _authService.getCurrentUserEmail();
    userId = _authService.getCurrentUserID();
    role = _authService.getCurrentUserRole();
    _journey = await controller.getJourneyFromSupabase(userId!);
  }

  void _buildPagesAndNavItems() {
    // Common pages for all users
    _pages = [
      SearchFlights(position: position!),
      SearchShuttles(position: position!, userId: userId!),
      ParcelLogistics(userId: userId!),
      MyItineraries(),
    ];

    // Common navigation items
    _navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.travel_explore),
        label: 'Flights',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Shuttles'),
      const BottomNavigationBarItem(
        icon: Icon(Icons.local_shipping),
        label: 'Cargo',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.luggage),
        label: 'Itineraries',
      ),
    ];

    // Add driver-specific items if needed
    if (role == 'driver') {
      _pages.add(
        Driver(
          role: role!,
          userId: userId!,
          journey: _journey,
          position: position!,
        ),
      );
      _navItems.add(
        const BottomNavigationBarItem(
          icon: Icon(Icons.drive_eta),
          label: 'Drive',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: Text(email ?? 'Guest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _authService.signOut(),
          ),
        ],
      ),
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
