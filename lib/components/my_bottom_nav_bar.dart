// components/my_bottom_nav_bar.dart
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isDriver;

  const MyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isDriver,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
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

    if (isDriver) {
      items.add(
        const BottomNavigationBarItem(
          icon: Icon(Icons.drive_eta),
          label: 'Drive',
        ),
      );
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
