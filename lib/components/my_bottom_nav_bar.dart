import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/screens/driver/views/driver.dart';
import 'package:travel_management_app_2/screens/flights/views/search_flights.dart';
import 'package:travel_management_app_2/screens/my_itineraries.dart';
import 'package:travel_management_app_2/screens/parcels/views/ship_parcel/parcel_logistics.dart';
import 'package:travel_management_app_2/screens/shuttles/views/search_shuttles.dart';

class MyBottomNavBar extends StatefulWidget {
  /*
  final String userId;
  final String role;
  final Position position;
  int currentIndex;
  */
  const MyBottomNavBar({
    super.key,
    // required this.userId,
    // required this.role,
    // required this.position,
  });

  @override
  State<MyBottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<MyBottomNavBar> {
  late List<Widget> _pages;
  late List<BottomNavigationBarItem> _navItems;
  int _currentIndex = 0;
  String? email;
  String? userId;
  String? role;
  bool _isLoading = true;
  final AuthService _authService = AuthService();
  Position? position;

  @override
  void initState() {
    super.initState();
    _initializeApp();
    log(_currentIndex.toString());
  }

  Future<void> _initializeApp() async {
    position = await _determinePosition();
    log(position.toString());
    await _fetchData();
    _buildPagesAndNavItems();
    setState(() => _isLoading = false);
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

  Future<void> _fetchData() async {
    email = _authService.getCurrentUserEmail();
    userId = _authService.getCurrentUserID();
    role = _authService.getCurrentUserRole();
  }

  void _buildPagesAndNavItems() {
    // Common pages for all users
    _pages = [
      SearchFlights(position: position!, userId: userId!),
      SearchShuttles(position: position!, userId: userId!),
      ParcelLogistics(userId: userId!),
      MyItineraries(userId: userId!),
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
      _pages.add(Driver(role: role!, userId: userId!, position: position!));
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

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap:
          (index) => setState(() {
            _currentIndex = index;
          }),
      items: _navItems,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );

    /*
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
        onTap:
            (index) => setState(() {
              _currentIndex = index;
            }),
        items: _navItems,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      
    );
    */
  }
}
