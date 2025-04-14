import 'package:flutter/material.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_booking.dart';

class ShuttleItineraryInfo extends StatefulWidget {
  final ShuttleBooking shuttleBooking;
  const ShuttleItineraryInfo({super.key, required this.shuttleBooking});

  @override
  State<ShuttleItineraryInfo> createState() => _ShuttleItineraryInfoState();
}

class _ShuttleItineraryInfoState extends State<ShuttleItineraryInfo> {
  Widget _buildItinerarySegment(ShuttleBooking booking) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Route Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    MySizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From', style: TextStyle(color: Colors.grey)),
                            Text(booking.origin ?? 'N/A'),
                            Text(booking.departureTime ?? 'N/A'),
                          ],
                        ),
                        const Icon(Icons.directions_bus, size: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('To', style: TextStyle(color: Colors.grey)),
                            Text(booking.destination ?? 'N/A'),
                            Text(booking.arrivalTime ?? 'N/A'),
                          ],
                        ),
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
                  'Ticket Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                MySizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date of departure:'),
                    Text(constants.formatDate(booking.departureDate!)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price:'),
                    Text('\$${booking.amountPaid?.toStringAsFixed(2)}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        MySizedBox(),
      ],
    );
  }

  Widget _buildPassengerSegment(ShuttleBooking booking) {
    return Column(
      children: [
        Card(
          // margin: const EdgeInsets.only(left: 5, bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Passenger Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                MySizedBox(height: 8),
                Table(
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
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(booking.firstName!),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(booking.lastName!),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(booking.email!),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Itinerary Info')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildItinerarySegment(widget.shuttleBooking),
            MySizedBox(),
            _buildPassengerSegment(widget.shuttleBooking),
          ],
        ),
      ),
    );
  }
}
