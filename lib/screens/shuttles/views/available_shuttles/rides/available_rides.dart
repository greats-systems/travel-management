import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/ride_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/ride_route.dart';
import 'package:travel_management_app_2/screens/shuttles/widgets/available_rides_map.dart';

class AvailableRides extends StatefulWidget {
  final String userId;
  final String origin;
  final String destination;
  const AvailableRides({
    super.key,
    required this.userId,
    required this.origin,
    required this.destination,
  });

  @override
  State<AvailableRides> createState() => _AvailableRidesState();
}

class _AvailableRidesState extends State<AvailableRides> {
  bool _isloading = false;
  List<RideRoute>? _routes;
  final RideController _rideController = RideController();
  /*
  Future<void> fetchData() async {
    if (mounted) {
      setState(() {
        _isloading = true;
      });
      await _rideController
          .getRideRoutes(widget.origin, widget.destination)
          .then((data) {
            setState(() {
              _routes = data;
              _isloading = false;
            });
          });
    }
  }
  */

  Widget _buildBody() {
    /*
    if (_isloading) {
      return Center(child: CircularProgressIndicator());
    }
    if (_routes!.isEmpty || _routes == null) {
      return Center(child: Text('No rides available'));
    }
    return SafeArea(
      child: AvailableRidesMap(route: _routes!, userId: widget.userId),
    );
    */
    return Center(child: Text('Available rides'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Rides')),
      body: _buildBody(),
    );
  }
}
