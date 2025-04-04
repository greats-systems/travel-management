import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';

// Airline logo mapping
String? returnCarrierLogo(String carrierCode) {
  final String assetRoot = 'assets/logos/airlines';
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
    "LX": "$assetRoot/swiss.png",
    "LH": "$assetRoot/lufthansa.png",
    "SN": "$assetRoot/brussels.png",
    "VS": "$assetRoot/virgin.png",
    "AC": "$assetRoot/air_canada.png",
    "KU": "$assetRoot/kuwait_airlines.png",
    "UA": "$assetRoot/united.png",
    "MS": "$assetRoot/egyptair.png",
    "5Z": "$assetRoot/cemair.png",
    "X1": "$assetRoot/hahn_air.png",
    "BP": "$assetRoot/air_botswana.png",
    "TM": "$assetRoot/air_mozambique.png",
  };
  return assetURLMap[carrierCode] ?? assetURLMap['KQ'];
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
    "LH": "Lufthansa",
    "LX": "Swiss",
    "SN": "Brussels Airlines",
    "VS": "Virgin Atlantic",
    "AC": "Air Canada",
    "KU": "Kuwait Airlines",
    "UA": "United Airlines",
    "MS": "Egypt Air",
    "5Z": "Cemair",
    "X1": "Hahn Air Technologies GmbH",
    "BP": "Air Botswana",
    "TM": "Linhas Aereas de Mocambique",
  };
  return carrierJson[carrierCode] ?? carrierCode;
}

// Airport name mapping
String returnAirportCode(String location) {
  const Map<String, String> locationMap = {
    "Harare": "HRE",
    "Bulawayo": "BUQ",
    "Nairobi": "NBO",
    "Dubai": "DXB",
    "Entebbe": "EBB",
    "Kigali": "KGL",
    "Johannesburg": "JNB",
    // "Jo'burg Lanseria": "HLA",
    "Lusaka": "LUN",
    "Doha": "DOH",
    "New York": "JFK",
    "Lilongwe": "LLW",
    "Addis Ababa": "ADD",
    "Amsterdam": "AMS",
    "London Heathrow": "LHR",
    "Singapore": "SIN",
    "Cape Town": "CPT",
    "Atlanta": "ATL",
    "Sydney": "YQY",
    "Montreal": "YUL",
    "S\u00E3o Paulo": "GRU",
    "Toronto": "YYZ",
    "Zurich": "ZRH",
    "Cairo": "CAI",
    "Manzini": "SHO",
    "Gaborone": "GBE",
    "Maputo": "MPM",
  };
  return locationMap[location] ?? location;
}

// Airport name mapping
String returnLocation(String airportCode) {
  const Map<String, String> airportCodeMap = {
    "HRE": "Harare",
    "BUQ": "Bulawayo",
    "NBO": "Nairobi",
    "DXB": "Dubai",
    "EBB": "Entebbe",
    "KGL": "Kigali",
    "JNB": "Jo'burg OR Tambo",
    "HLA": "Jo'burg Lanseria",
    "LUN": "Lusaka",
    "DOH": "Doha",
    "JFK": "New York",
    "LLW": "Lilongwe",
    "ADD": "Addis Ababa",
    "AMS": "Amsterdam",
    "LHR": "London Heathrow",
    "SIN": "Singapore",
    "CPT": "Cape Town",
    "ATL": "Atlanta",
    "YQY": "Sydney",
    "YUL": "Montreal",
    "GRU": "S\u00E3o Paulo",
    "YYZ": "Toronto",
    "ZRH": "Zurich",
    "CAI": "Cairo",
    "SHO": "Manzini",
    "GBE": "Gaborone",
    "MPM": "Maputo",
  };
  return airportCodeMap[airportCode] ?? airportCode;
}

String formatDateTime(String isoString) {
  try {
    final dateTime = DateTime.parse(isoString);
    return DateFormat('d MMM yyyy, hh:mm').format(dateTime);
  } catch (e) {
    return isoString;
  }
}

String calculateDuration(String departure, String arrival) {
  try {
    final start = DateTime.parse(departure);
    final end = DateTime.parse(arrival);
    final duration = end.difference(start);
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
  } catch (e) {
    return '';
  }
}

// Format time string
String formatTime(String isoTime) {
  return isoTime.substring(11, 16); // Extracts HH:MM
}

String getOriginDestinationSummary(List<dynamic> segments) {
  if (segments.isEmpty) return 'No flight information available';

  final firstSegment = segments.first;
  final lastSegment = segments.last;

  final origin = returnLocation(firstSegment['departure']['iataCode']);
  final destination = returnLocation(lastSegment['arrival']['iataCode']);

  return '$origin → $destination';
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

    // buffer.writeln('Price: €${flight.price}');
  }
  log('buffer ${buffer.toString()}');
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
