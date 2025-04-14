import 'package:flutter/material.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'dart:developer';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_route.dart';
import 'package:travel_management_app_2/screens/shuttles/views/available_shuttles/book_shuttle.dart';

class ShuttleServicesInfo extends StatefulWidget {
  // final String companyId;
  final String departureDate;
  final ShuttleRoute shuttleRoute;
  const ShuttleServicesInfo({
    super.key,
    // required this.companyId,
    required this.shuttleRoute,
    required this.departureDate,
  });

  @override
  State<ShuttleServicesInfo> createState() => _ShuttleServicesInfoState();
}

class _ShuttleServicesInfoState extends State<ShuttleServicesInfo> {
  final AuthService authService = AuthService();
  List<ShuttleRoute>? _shuttleRoutes;
  String? userId;
  bool _isLoading = true;
  final ShuttleController shuttleController = ShuttleController();

  Future<void> fetchData() async {
    try {
      setState(() => _isLoading = true);
      final data = await shuttleController.getShuttleRoutes(
        widget.shuttleRoute.origin!,
        widget.shuttleRoute.destination!,
      );
      userId = authService.getCurrentUserID();
      if (mounted) {
        setState(() {
          _shuttleRoutes = data;
          _isLoading = false;
          // _shuttleBooking.
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

  book(
    String companyId,
    String routeId,
    String origin,
    String destination,
    String departureDate,
    double amountPaid,
  ) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BookShuttle(
              companyId: companyId,
              routeId: routeId,
              userId: userId,
              origin: origin,
              destination: destination,
              departureDate: departureDate,
              amountPaid: amountPaid,
            ),
      ),
    );
  }

  Widget _buildRouteSegment(ShuttleRoute shuttleRoute) {
    return Column(
      children: [
        Card(
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
        ),
        MySizedBox(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pricing Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                MySizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price:'),
                    Text('\$${shuttleRoute.price?.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        MySizedBox(),
        MyButton(
          onTap: () {
            book(
              shuttleRoute.companyID!,
              shuttleRoute.routeID!,
              shuttleRoute.origin!,
              shuttleRoute.destination!,
              widget.departureDate,
              shuttleRoute.price!,
            );
          },
          text: 'Book',
          color: Colors.blue.shade300,
        ),
      ],
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
