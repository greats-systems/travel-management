import 'dart:convert';
import 'dart:developer';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/extensions/string_extensions.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
// import

class ItinerariesInfo extends StatefulWidget {
  final Booking booking;
  // final String id;

  const ItinerariesInfo({super.key, required this.booking});

  @override
  State<ItinerariesInfo> createState() => _ItinerariesInfoState();
}

class _ItinerariesInfoState extends State<ItinerariesInfo> {
  Widget _buildPassengerSegment(List<dynamic> travelers) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(left: 5, bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FixedColumnWidth(80),
                2: FixedColumnWidth(150),
              },
              border: TableBorder.all(color: Colors.grey.shade200),
              children: [
                // Header row
                TableRow(
                  decoration: BoxDecoration(color: Colors.blue[50]),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      child: Text(
                        'First name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Last name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                // Passenger rows
                ...travelers.map(
                  (traveler) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          traveler['name']['firstName']
                                  ?.toString()
                                  .capitalize() ??
                              '',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          traveler['name']['lastName']
                                  ?.toString()
                                  .capitalize() ??
                              '',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          traveler['contact']['emailAddress']?.toString() ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingSegment(
    Map<String, dynamic> segment,
    int index,
    int totalSegments,
  ) {
    // log(segment.toString());
    final departure = segment['departure'];
    final arrival = segment['arrival'];
    final carrierCode = segment['carrierCode'];
    final flightNumber = segment['number'];
    final aircraft = segment['aircraft']?['code'] ?? 'Unknown';

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
                      label: Text(segment['class'] ?? "ECONOMY"),
                      backgroundColor: Colors.blue[50],
                    ),
                  ],
                ),
                MySizedBox(height: 12),
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
                MySizedBox(height: 8),
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
                MySizedBox(width: 16),
                Icon(Icons.airline_seat_individual_suite_rounded, size: 16),
                MySizedBox(width: 8),
                Text(
                  'Layover in ${constants.returnLocation(arrival['iataCode'])}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPricingInfo(Booking booking) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receipt',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            MySizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amount Paid:'),
                Text(
                  '\$${booking.price!['total']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date of Payment:'),
                Text(
                  constants.formatDateTime(booking.createdAt!),
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
  void initState() {
    super.initState();
    log(JsonEncoder.withIndent(' ').convert(widget.booking));
  }

  @override
  Widget build(BuildContext context) {
    final itineraries = widget.booking.itineraries ?? [];
    final isRoundTrip = itineraries.length > 1;

    return Scaffold(
      appBar: AppBar(title: Text('Itinerary info')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                // Outbound flight
                if (itineraries.isNotEmpty) ...[
                  Text(
                    'Outbound Flight',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  MySizedBox(),
                  ...itineraries[0]['segments'].asMap().entries.map((entry) {
                    final index = entry.key;
                    return _buildBookingSegment(
                      entry.value,
                      index,
                      itineraries[0]['segments'].length,
                    );
                  }),
                  MySizedBox(),
                ],

                // Return Flight (if round trip)
                if (isRoundTrip && itineraries.length > 1) ...[
                  Text(
                    'Return Flight',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  MySizedBox(),
                  ...itineraries[1]['segments'].asMap().entries.map((entry) {
                    final index = entry.key;
                    return _buildBookingSegment(
                      entry.value,
                      index,
                      itineraries[1]['segments'].length,
                    );
                  }),
                  MySizedBox(),
                ],
              ],
            ),
            Text(
              'Passengers',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            _buildPassengerSegment(widget.booking.travelers!),
            MySizedBox(),
            _buildPricingInfo(widget.booking),
          ],
        ),
      ),
    );
  }
}
