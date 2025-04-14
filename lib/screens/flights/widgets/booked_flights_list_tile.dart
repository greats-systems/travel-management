import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
import 'package:travel_management_app_2/screens/flights/views/itinerary/flight_itinerary_info.dart';

class BookedFlightsListTile extends StatelessWidget {
  final List<FlightBooking> flightBookings;
  final String id;
  const BookedFlightsListTile({
    super.key,
    required this.flightBookings,
    required this.id,
  });

  Widget buildBookingsTile(FlightBooking flightBooking, BuildContext context) {
    final itineraries = flightBooking.itineraries!;
    final airlines = <String>{};

    for (final itinerary in itineraries) {
      airlines.add(itinerary['segments'][0]['carrierCode']);
    }
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
    price = flightBooking.price!['total'];
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    FlightItinerariesInfo(flightBooking: flightBooking),
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
        Expanded(
          child: ListView.builder(
            itemCount: flightBookings.length,
            itemBuilder: (context, index) {
              final flightBooking = flightBookings[index];
              return ListTile(title: buildBookingsTile(flightBooking, context));
            },
          ),
        ),
      ],
    );
  }
}
