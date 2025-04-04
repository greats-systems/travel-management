import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/screens/flights/views/flight_info.dart';

class MyListTile extends StatelessWidget {
  final List<Flight>? flights;
  // final String assetRoot = 'assets/logos/airlines';

  const MyListTile({super.key, required this.flights});

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
              'Operated by ${airlines.join(' and ')}',
              style: TextStyle(fontSize: 12),
            ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '€${flight.price!.toStringAsFixed(2)}',
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
          MaterialPageRoute(builder: (context) => FlightInfo(flight: flight)),
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
