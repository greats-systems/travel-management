// import 'dart:convert';
import 'dart:developer';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
import 'package:travel_management_app_2/screens/flights/views/itinerary/itinerary_info.dart';

class BookedFlightsListTile extends StatelessWidget {
  final List<Booking> bookings;
  final String id;
  const BookedFlightsListTile({
    super.key,
    required this.bookings,
    required this.id,
  });

  Widget buildBookingsTile(Booking booking, BuildContext context) {
    final itineraries = booking.itineraries!;
    final airlines = <String>{};

    for (final itinerary in itineraries) {
      airlines.add(itinerary['segments'][0]['carrierCode']);
    }
    // log('Airlines: $airlines');
    // log('origin: ${itineraries[0]['segments'][0]['departure']}');
    // log('1st stop arrival: ${itineraries[0]['segments'][0]['arrival']}');
    // log('1st stop departure: ${itineraries[0]['segments'][1]['departure']}');
    // log('destination: ${itineraries[0]['segments'][1]['arrival']}');
    final isMultiAirline = airlines.length > 1;
    final dynamic firstAirlineCode;
    final dynamic logoURL;
    final String airlineName;
    final String routeSummary;
    final String price;

    firstAirlineCode = airlines.first;
    logoURL = constants.returnCarrierLogo(firstAirlineCode);
    routeSummary = constants.getItineraryRouteSummary(
      itineraries[0]['segments'],
    );
    airlineName = constants.returnCarrierName(firstAirlineCode);
    price = booking.price!['total'];
    log('Booking price: ${price}');
    // routeSummary = constants.getOriginDestinationSummary(itineraries);
    // final carrierCode = booking.itineraries![0]['segments'][0]['carrierCode'];
    // final
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItinerariesInfo(booking: booking),
          ),
        );
      },
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logoURL!, width: 40, height: 40),
          if (isMultiAirline)
            Text(
              '+ ${airlines.length - 1} more',
              style: TextStyle(fontSize: 10),
            ),
        ],
      ),
      title: Text(routeSummary),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(airlineName),
          if (isMultiAirline)
            Text(
              'Operated by ${airlines.map((code) => constants.returnCarrierName(code)).join(' and ')}',
              style: TextStyle(fontSize: 12),
            ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('\$$price')],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text('Itineraries'),
        Expanded(
          child: ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return ListTile(title: buildBookingsTile(booking, context));
            },
          ),
        ),
      ],
    );
  }
}
