import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';

class MyListTile extends StatelessWidget {
  final List<Flight>? flights;
  final String assetRoot = 'assets/logos/airlines';

  MyListTile({super.key, required this.flights});

  // Airline logo mapping
  String returnCarrierLogo(String carrierCode) {
    final Map<String, String> assetURLMap = {
      "KQ": "$assetRoot/kenya_airways.png",
      "ET": "$assetRoot/ethiopian.png",
      "UR": "$assetRoot/uganda_airlines.png",
      "WB": "$assetRoot/rwandair.png",
      "EK": "$assetRoot/emirates.png",
      "QR": "$assetRoot/qatar.png",
      "SA": "$assetRoot/saa.png",
      "4Z": "$assetRoot/airlink.png",
      "AF": "$assetRoot/air_france.png",
      "KL": "$assetRoot/KLM.png",
    };
    return assetURLMap[carrierCode]!;
  }

  // Airline name mapping
  String returnCarrierName(String carrierCode) {
    const Map<String, String> carrierJson = {
      "KQ": "Kenya Airways",
      "ET": "Ethiopian Airlines",
      "UR": "Uganda Airlines",
      "WB": "RwandAir",
      "EK": "Emirates",
      "QR": "Qatar Airways",
      "SA": "South African Airways",
      "4Z": "Airlink",
      "AF": "Air France",
      "KL": "KLM",
    };
    return carrierJson[carrierCode]!;
  }

  // Airport name mapping
  String returnLocation(String airportCode) {
    const Map<String, String> airportCodeMap = {
      "HRE": "Harare",
      "NBO": "Nairobi",
      "DXB": "Dubai",
      "EBB": "Entebbe",
      "KGL": "Kigali",
      "JNB": "Johannesburg",
      "LUN": "Lusaka",
      "DOH": "Doha",
      "JFK": "New York",
    };
    return airportCodeMap[airportCode] ?? airportCode;
  }

  // Format time string
  String formatTime(String isoTime) {
    return isoTime.substring(11, 16); // Extracts HH:MM
  }

  // Build flight itinerary text
  String buildItineraryText(List<dynamic> segments) {
    final buffer = StringBuffer();

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final departure = segment['departure'];
      final arrival = segment['arrival'];

      buffer.writeln(
        'Depart ${returnLocation(departure['iataCode'])}: ${formatTime(departure['at'])}',
      );
      buffer.writeln(
        'Arrive ${returnLocation(arrival['iataCode'])}: ${formatTime(arrival['at'])}',
      );

      if (i < segments.length - 1) {
        // Calculate layover time
        final nextDeparture = segments[i + 1]['departure']['at'];
        final layoverDuration = DateTime.parse(
          nextDeparture,
        ).difference(DateTime.parse(arrival['at']));
        buffer.writeln(
          'Layover: ${layoverDuration.inHours}h ${layoverDuration.inMinutes.remainder(60)}m',
        );
      }
    }

    return buffer.toString();
  }

  // Build flight duration text
  String buildDurationText(List<dynamic> segments) {
    final firstDeparture = segments.first['departure']['at'];
    final lastArrival = segments.last['arrival']['at'];
    final totalDuration = DateTime.parse(
      lastArrival,
    ).difference(DateTime.parse(firstDeparture));

    return 'Total: ${totalDuration.inHours}h ${totalDuration.inMinutes.remainder(60)}m';
  }

  // Build ListTile for any flight (regardless of layovers)
  Widget buildFlightTile(Flight flight) {
    final segments = flight.itineraries![0]['segments'];
    final carrierCode = segments[0]['carrierCode'].toString();
    final price = flight.price!.toStringAsFixed(2);
    final logoURL = returnCarrierLogo(carrierCode);
    final airlineName = returnCarrierName(carrierCode);

    return ListTile(
      leading: Image.asset(logoURL, width: 80, height: 80),
      title: Text(
        airlineName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(buildItineraryText(segments)),
          const SizedBox(height: 4),
          Text(
            buildDurationText(segments),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      trailing: Text('€$price'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flights?.length ?? 0,
      itemBuilder: (context, index) {
        final flight = flights![index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: buildFlightTile(flight),
        );
      },
    );
  }
}
