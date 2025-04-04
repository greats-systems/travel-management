
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class FlightInfo extends StatelessWidget {
  final Flight flight;

  const FlightInfo({super.key, required this.flight});

  Widget _buildFlightSegment(
    Map<String, dynamic> segment,
    int index,
    int totalSegments,
  ) {
    final departure = segment['departure'];
    final arrival = segment['arrival'];
    final carrierCode = segment['carrierCode'];
    final flightNumber = segment['number'];
    final aircraft = segment['aircraft']?['code'] ?? 'Unknown';
    // log('segment: $segment');

    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$carrierCode$flightNumber',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Chip(
                      label: Text(segment['class'] ?? 'ECONOMY'),
                      backgroundColor: Colors.blue[50],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From', style: TextStyle(color: Colors.grey)),
                        Text(constants.returnLocation(departure['iataCode'])),
                        Text(constants.formatDateTime(departure['at'])),
                        if (departure['terminal'] != null)
                          Text('Terminal ${departure['terminal']}'),
                      ],
                    ),
                    Icon(Icons.airplanemode_active, size: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('To', style: TextStyle(color: Colors.grey)),
                        Text(constants.returnLocation(arrival['iataCode'])),
                        Text(constants.formatDateTime(arrival['at'])),
                        if (arrival['terminal'] != null)
                          Text('Terminal ${arrival['terminal']}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Duration: ${constants.calculateDuration(departure['at'], arrival['at'])}',
                ),
                Text('Aircraft: $aircraft'),
              ],
            ),
          ),
        ),
        if (index < totalSegments - 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.airline_seat_individual_suite_rounded, size: 16),
                SizedBox(width: 8),
                Text(
                  'Layover at ${constants.returnLocation(arrival['iataCode'])}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPricingInfo() {
    // log('_buildPricingInfo ${flight.itineraries}');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price:'),
                Text(
                  '€${flight.price?.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
    final itineraries = flight.itineraries ?? [];
    final isRoundTrip = itineraries.length > 1;

    return Scaffold(
      appBar: AppBar(title: Text('Flight Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Outbound Flight
            if (itineraries.isNotEmpty) ...[
              Text(
                'Outbound Flight',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 12),
              ...itineraries[0]['segments'].asMap().entries.map((entry) {
                final index = entry.key;
                return _buildFlightSegment(
                  entry.value,
                  index,
                  itineraries[0]['segments'].length,
                );
              }),
              SizedBox(height: 20),
            ],

            // Return Flight (if round trip)
            if (isRoundTrip && itineraries.length > 1) ...[
              Text(
                'Return Flight',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 12),
              ...itineraries[1]['segments'].asMap().entries.map((entry) {
                final index = entry.key;
                return _buildFlightSegment(
                  entry.value,
                  index,
                  itineraries[1]['segments'].length,
                );
              }),
              SizedBox(height: 20),
            ],

            _buildPricingInfo(),
            SizedBox(height: 20),

            if (flight.Id != null)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.confirmation_number),
                title: Text('Booking Reference'),
                subtitle: Text(flight.Id!),
              ),
          ],
        ),
      ),
    );
  }
}
