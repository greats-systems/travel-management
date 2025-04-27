import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/flights/views/available_flights/book_flight.dart';

class FlightInfo extends StatefulWidget {
  final Flight flight;
  final String origin;
  final String destination;
  final String departureDate;
  final String? returnDate;
  final int adults;

  const FlightInfo({
    super.key,
    required this.flight,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.returnDate,
    required this.adults,
  });

  @override
  State<FlightInfo> createState() => _FlightInfoState();
}

class _FlightInfoState extends State<FlightInfo> {
  @override
  void initState() {
    super.initState();
  }

  void bookThisFlight() async {
    log('Flight:\n${JsonEncoder.withIndent(' ').convert(widget.flight)}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BookFlight(
              flight: widget.flight,
              origin: widget.origin,
              destination: widget.destination,
              departureDate: widget.departureDate,
              returnDate: widget.returnDate,
              adults: widget.adults,
            ),
      ),
    );
  }

  Widget _buildFlightSegment(
    String? cabinClass,
    Map<String, dynamic> segment,
    int index,
    int totalSegments,
  ) {
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
                      label: Text(cabinClass ?? ''),
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

  Widget _buildPricingInfo() {
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
            MySizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price:'),
                Text('\$${widget.flight.price?.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookableSeats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Capacity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            MySizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Available seats:'),
                Text('${widget.flight.bookableSeats}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itineraries = widget.flight.itineraries ?? [];
    final cabinClass =
        widget.flight
            .toJson()['travelerPricings'][0]['fareDetailsBySegment'][0]['cabin'];
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
              MySizedBox(),
              ...itineraries[0]['segments'].asMap().entries.map((entry) {
                final index = entry.key;
                return _buildFlightSegment(
                  cabinClass,
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
                return _buildFlightSegment(
                  cabinClass,
                  entry.value,
                  index,
                  itineraries[1]['segments'].length,
                );
              }),
              MySizedBox(),
            ],

            _buildPricingInfo(),
            MySizedBox(),
            _buildBookableSeats(),

            if (widget.flight.Id != null)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.confirmation_number),
                title: Text('Booking Reference'),
                subtitle: Text(widget.flight.Id!),
              ),
            MySizedBox(),
            MyButton(
              onTap: bookThisFlight,
              text: 'Book this flight',
              color: Colors.blue.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
