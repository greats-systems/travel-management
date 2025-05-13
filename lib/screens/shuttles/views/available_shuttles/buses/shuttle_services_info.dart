import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_route.dart';
import 'package:travel_management_app_2/screens/shuttles/views/available_shuttles/buses/book_shuttle.dart';

class ShuttleServicesInfo extends StatefulWidget {
  final String userId;
  final String departureDate;
  final ShuttleRoute shuttleRoute;
  const ShuttleServicesInfo({
    super.key,
    required this.userId,
    required this.shuttleRoute,
    required this.departureDate,
  });

  @override
  State<ShuttleServicesInfo> createState() => _ShuttleServicesInfoState();
}

class _ShuttleServicesInfoState extends State<ShuttleServicesInfo> {
  final ShuttleController shuttleController = ShuttleController();

  @override
  void initState() {
    super.initState();
  }

  book(
    String companyId,
    String companyName,
    String routeId,
    String origin,
    String destination,
    String departureDate,
    String departureTime,
    String arrivlTime,
    double amountPaid,
  ) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BookShuttle(
              companyId: companyId,
              companyName: companyName,
              routeId: routeId,
              userId: widget.userId,
              origin: origin,
              destination: destination,
              departureDate: departureDate,
              departureTime: departureTime,
              arrivalTime: arrivlTime,
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
                Text(
                  'Route Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
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
            log(shuttleRoute.shuttleServiceCompany!['name']);
            book(
              shuttleRoute.companyID!,
              shuttleRoute.shuttleServiceCompany!['name'],
              shuttleRoute.routeID!,
              shuttleRoute.origin!,
              shuttleRoute.destination!,
              widget.departureDate,
              shuttleRoute.departureTime!,
              shuttleRoute.arrivalTime!,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildRouteSegment(widget.shuttleRoute),
      ),
    );
  }
}
