import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_route.dart';

class ShuttleServicesInfo extends StatefulWidget {
  // final List<ShuttleRoute> shuttleRoutes;
  // const ShuttleServicesInfo({super.key, required this.shuttleRoutes});

  final Shuttle shuttle;
  const ShuttleServicesInfo({super.key, required this.shuttle});

  @override
  State<ShuttleServicesInfo> createState() => _ShuttleServicesInfoState();
}

class _ShuttleServicesInfoState extends State<ShuttleServicesInfo> {
  List<ShuttleRoute>? _shuttleRoutes;
  bool _isLoading = true;
  final ShuttleController shuttleController = ShuttleController();

  Future<void> fetchData() async {
    try {
      setState(() => _isLoading = true);
      final data = await shuttleController.getShuttleRoutes(
        widget.shuttle.companyID!,
      );
      if (mounted) {
        setState(() {
          _shuttleRoutes = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      log('Error fetching shuttle routes: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget _buildRouteSegment(ShuttleRoute shuttleRoute) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('From', style: TextStyle(color: Colors.grey)),
                    Text(shuttleRoute.origin ?? 'N/A'),
                    Text(shuttleRoute.departureTime ?? 'N/A'),
                  ],
                ),
                const Icon(Icons.directions_bus, size: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('To', style: TextStyle(color: Colors.grey)),
                    Text(shuttleRoute.destination ?? 'N/A'),
                    Text(shuttleRoute.arrivalTime ?? 'N/A'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Routes Info')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (_shuttleRoutes != null &&
                        _shuttleRoutes!.isNotEmpty) ...[
                      const Text(
                        'Outbound Journey',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._shuttleRoutes!.map(_buildRouteSegment),
                    ] else ...[
                      const Center(child: Text('No routes available')),
                    ],
                  ],
                ),
              ),
    );
  }
}
