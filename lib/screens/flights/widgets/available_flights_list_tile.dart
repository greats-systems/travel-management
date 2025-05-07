import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/screens/flights/views/available_flights/flight_info.dart';

class AvailableFlightsListTile extends StatelessWidget {
  final String userId;
  final List<Flight>? flights;
  final String origin;
  final String destination;
  final String departureDate;
  final String? returnDate;
  final int adults;

  const AvailableFlightsListTile({
    super.key,
    required this.userId,
    required this.flights,
    required this.origin,
    required this.destination,
    required this.departureDate,
    required this.returnDate,
    required this.adults,
  });

  // Build ListTile for any flight (regardless of layovers)
  Widget buildFlightTile(Flight flight, BuildContext context) {
    final segments = flight.itineraries![0]['segments'];
    final airlines = <String>{}; // Using a Set to collect unique airlines

    // Collect all unique airline codes
    for (final segment in segments) {
      airlines.add(segment['carrierCode'].toString());
    }

    // Get display information
    final isMultiAirline = airlines.length > 1;
    final dynamic firstAirlineCode;
    final dynamic logoURL;
    final String airlineName;
    final String routeSummary;

    firstAirlineCode = segments[0]['carrierCode'].toString();
    logoURL = constants.returnCarrierLogo(firstAirlineCode);
    airlineName = constants.returnCarrierName(firstAirlineCode);
    routeSummary = constants.getOriginDestinationSummary(segments);

    return ListTile(
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
        children: [
          Text(
            '\$${flight.price!.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (segments.length > 1)
            Text(
              '${segments.length - 1} stop${segments.length > 2 ? 's' : ''}',
              style: TextStyle(fontSize: 12),
            ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => FlightInfo(
                  userId: userId,
                  flight: flight,
                  origin: origin,
                  destination: destination,
                  departureDate: departureDate,
                  returnDate: returnDate,
                  adults: adults,
                ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: flights?.length ?? 0,
            itemBuilder: (context, index) {
              final flight = flights![index];
              return ListTile(title: buildFlightTile(flight, context));
            },
          ),
        ),
      ],
    );
  }
}
