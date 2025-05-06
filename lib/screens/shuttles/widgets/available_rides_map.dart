import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/models/ride_route.dart';

class AvailableRidesMap extends StatefulWidget {
  final List<RideRoute> route;
  final String userId;
  const AvailableRidesMap({
    super.key,
    required this.route,
    required this.userId,
  });

  @override
  State<AvailableRidesMap> createState() => _AvailableRidesMapState();
}

class _AvailableRidesMapState extends State<AvailableRidesMap> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Available rides map'));
  }
}
