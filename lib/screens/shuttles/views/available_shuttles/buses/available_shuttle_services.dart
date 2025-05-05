import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_route.dart';
import 'package:travel_management_app_2/screens/shuttles/widgets/available_shuttle_services_list_tile.dart';

class AvailableShuttleServices extends StatefulWidget {
  final String origin;
  final String destination;
  final String departureDate;
  const AvailableShuttleServices({
    super.key,
    required this.origin,
    required this.destination,
    required this.departureDate,
  });

  @override
  State<AvailableShuttleServices> createState() =>
      _AvailableShuttleServicesState();
}

class _AvailableShuttleServicesState extends State<AvailableShuttleServices> {
  bool _isloading = true;
  List<ShuttleRoute>? _shuttleRoutes;
  final ShuttleController shuttleController = ShuttleController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (mounted) {
      setState(() {
        _isloading = true;
      });
      await shuttleController
          .getShuttleRoutes(
            origin: widget.origin,
            destination: widget.destination,
          )
          .then((data) {
            setState(() {
              _shuttleRoutes = data;
              _isloading = false;
            });
          });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBody() {
    if (_isloading) {
      return Center(child: CircularProgressIndicator());
    }
    if (_shuttleRoutes!.isEmpty || _shuttleRoutes == null) {
      return Center(child: Text('No shuttles available'));
    }
    return SafeArea(
      child: AvailableShuttleServicesListTile(
        shuttleRoutes: _shuttleRoutes,
        departureDate: widget.departureDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Shuttles')),
      body: _buildBody(),
    );
  }
}
