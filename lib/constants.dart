import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';

// Logo
const logoURL = 'assets/logos/companies/lighttraveller2.png';

// Backend URL
const apiRoot = 'http://10.0.2.2:5000';

// Shuttle logo mapping
String? returnShuttleCompanyLogo(String companyName) {
  final String shuttleCompanyAssetsRoot =
      'assets/logos/companies/shuttle_services';
  final Map<String, String> assetURLMap = {
    "Galaxy Coaches": "$shuttleCompanyAssetsRoot/galaxy_coaches.jpg",
    "CAG Travellers Coaches": "$shuttleCompanyAssetsRoot/CAG.jpg",
    "Inter Africa": "$shuttleCompanyAssetsRoot/inter_africa.jpg",
    "No Logo": "$shuttleCompanyAssetsRoot/not_found.png",
  };
  return assetURLMap[companyName] ?? assetURLMap["No Logo"];
}

// JSON formatter
String formatJson(Map<String, dynamic> json) {
  return JsonEncoder.withIndent('indent').convert(json);
}

// Courier logo mapping
String? returnCourierLogo(String courierName) {
  final String courierAssetsRoot = 'assets/logos/companies/couriers';
  final Map<String, String> assetURLMap = {
    "DHL": "$courierAssetsRoot/dhl2.png",
    "FedEx": "$courierAssetsRoot/fedex.png",
    "UPS": "$courierAssetsRoot/ups.png",
    "InDrive": "$courierAssetsRoot/indrive.png",
    "No Logo": "$courierAssetsRoot/not_found.png",
  };
  return assetURLMap[courierName] ?? assetURLMap["No Logo"];
}

// Airline logo mapping
String? returnCarrierLogo(String carrierCode) {
  final String airlineAssetsRoot = 'assets/logos/airlines';
  final Map<String, String> assetURLMap = {
    "KQ": "$airlineAssetsRoot/kenya_airways.png",
    "ET": "$airlineAssetsRoot/ethiopian.png",
    "UR": "$airlineAssetsRoot/uganda_airlines.png",
    "WB": "$airlineAssetsRoot/rwandair.png",
    "EK": "$airlineAssetsRoot/emirates.png",
    "QR": "$airlineAssetsRoot/qatar.png",
    "SA": "$airlineAssetsRoot/saa.png",
    "4Z": "$airlineAssetsRoot/airlink.png",
    "AF": "$airlineAssetsRoot/air_france.png",
    "KL": "$airlineAssetsRoot/KLM.png",
    "LX": "$airlineAssetsRoot/swiss.png",
    "LH": "$airlineAssetsRoot/lufthansa.png",
    "SN": "$airlineAssetsRoot/brussels.png",
    "VS": "$airlineAssetsRoot/virgin.png",
    "AC": "$airlineAssetsRoot/air_canada.png",
    "KU": "$airlineAssetsRoot/kuwait_airlines.png",
    "UA": "$airlineAssetsRoot/united.png",
    "MS": "$airlineAssetsRoot/egyptair.png",
    "5Z": "$airlineAssetsRoot/cemair.png",
    "X1": "$airlineAssetsRoot/hahn_air.png",
    "BP": "$airlineAssetsRoot/air_botswana.png",
    "TM": "$airlineAssetsRoot/air_mozambique.png",
    "SQ": "$airlineAssetsRoot/singapore_airlines.png",
    "CX": "$airlineAssetsRoot/cathay_pacific.png",
    "GK": "$airlineAssetsRoot/jetstar.png",
    "JL": "$airlineAssetsRoot/japan_airlines.png",
    "TG": "$airlineAssetsRoot/thai.png",
    "NH": "$airlineAssetsRoot/ana.png",
    "OZ": "$airlineAssetsRoot/asiana.png",
    "OS": "$airlineAssetsRoot/austrian.png",
    "AZ": "$airlineAssetsRoot/alitalia.png",
    "FN": "$airlineAssetsRoot/fastjet.png",
    "TK": "$airlineAssetsRoot/turkish.png",
    "FA": "$airlineAssetsRoot/flysafair.png",
    "H1": "$airlineAssetsRoot/hahn_air.png",
    "TC": "$airlineAssetsRoot/air_tanzania.png",
    "RN": "$airlineAssetsRoot/royal_eswatini.png",
    "B6": "$airlineAssetsRoot/jetblue.png",
    "AI": "$airlineAssetsRoot/air_india.png",
    "KE": "$airlineAssetsRoot/korean.png",
    "F9": "$airlineAssetsRoot/frontier.png",
    "LY": "$airlineAssetsRoot/el_al.png",
    "SV": "$airlineAssetsRoot/saudi_arabian_airlines.png",
    "FI": "$airlineAssetsRoot/icelandair.png",
    "SK": "$airlineAssetsRoot/sas.png",
    "AS": "$airlineAssetsRoot/alaska_airlines.png",
    "IB": "$airlineAssetsRoot/iberia.png",
    "AY": "$airlineAssetsRoot/finnair.png",
    "EI": "$airlineAssetsRoot/aer_lingus.png",
    "LO": "$airlineAssetsRoot/polish.png",
    "LA": "$airlineAssetsRoot/latam.png",
    "TP": "$airlineAssetsRoot/tap_portugal.png",
    "AT": "$airlineAssetsRoot/royal_air_maroc.png",
    "WS": "$airlineAssetsRoot/westjet.png",
    "HA": "$airlineAssetsRoot/hawaiian.png",
    "PD": "$airlineAssetsRoot/porter.png",
    "TS": "$airlineAssetsRoot/air_transat.png",
    "VF": "$airlineAssetsRoot/ajet.png",
    "ME": "$airlineAssetsRoot/mea.png",
    "GF": "$airlineAssetsRoot/gulf_air.png",
    "KM": "$airlineAssetsRoot/malta_airlines.png",
    "VY": "$airlineAssetsRoot/vueling.png",
    "A3": "$airlineAssetsRoot/aegean.png",
    "P6": "$airlineAssetsRoot/privilege.png",
    "CZ": "$airlineAssetsRoot/china_southern.png",
    "MU": "$airlineAssetsRoot/china_eastern.png",
    "EY": "$airlineAssetsRoot/etihad.png",
    "UL": "$airlineAssetsRoot/srilankan.png",
    "WY": "$airlineAssetsRoot/omanair.png",
    "BR": "$airlineAssetsRoot/eva_air.png",
    "CI": "$airlineAssetsRoot/china_airlines.png",
    "PR": "$airlineAssetsRoot/philippine_airlines.png",
    "HX": "$airlineAssetsRoot/hongkong_airlines.png",
    "MK": "$airlineAssetsRoot/air_mauritius.png",
    "CA": "$airlineAssetsRoot/air_china.png",
    "MF": "$airlineAssetsRoot/shanghai_airlines.png",
    "MH": "$airlineAssetsRoot/malaysia_airlines.png",
    "FM": "$airlineAssetsRoot/xiamen_air.png",
    "UO": "$airlineAssetsRoot/hk_express.png",
    "TW": "$airlineAssetsRoot/tway.png",
    "7C": "$airlineAssetsRoot/coyne.png",
    "SC": "$airlineAssetsRoot/shadong_airlines.png",
    "VJ": "$airlineAssetsRoot/vietjet.png",
    "LJ": "$airlineAssetsRoot/jinair.png",
    "HB": "$airlineAssetsRoot/greater_bay_airlines.png",
    "NX": "$airlineAssetsRoot/air_macau.png",
    "QF": "$airlineAssetsRoot/qantas.png",
    "HO": "$airlineAssetsRoot/juneyao_airlines.png",
    "VN": "$airlineAssetsRoot/vietnam_airlines.png",
    "HU": "$airlineAssetsRoot/hainian_airlines.png",
    "OD": "$airlineAssetsRoot/malindo_air.png",
    "3U": "$airlineAssetsRoot/sichuan.png",
    "ZH": "$airlineAssetsRoot/shenzhen.png",
    "JD": "$airlineAssetsRoot/beijing_capital_airlines.png",
    "RJ": "$airlineAssetsRoot/royal_jordanian.png",
    "nologo": "$airlineAssetsRoot/not_found.png",
  };
  return assetURLMap[carrierCode] ?? assetURLMap['nologo'];
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
    "SQ": "Singapore Airlines",
    "GK": "Jetstar Japan",
    "CX": "Cathay Pacific",
    "JL": "Japan Airlines",
    "TG": "Thai Airways",
    "NH": "All Nippon Airways",
    "OZ": "Asiana Airlines",
    "OS": "Austrian Airlines",
    "AZ": "Alitalia",
    "FN": "Fastjet",
    "TK": "Turkish Airlines",
    "FA": "Fly Safair",
    "H1": "Hahn Air Systems",
    "TC": "Air Tanzania",
    "RN": "Royal Eswatini",
    "B6": "Jetblue",
    "AI": "Air India",
    "KE": "Korean Airlines",
    "F9": "Frontier Airlines",
    "LY": "EL AL Israel Airlines",
    "SV": "Saudi Arabian Airlines",
    "FI": "Icelandair",
    "SK": "Scandinavian Air Systems",
    "AS": "Alaska Airlines",
    "IB": "Iberia Lineas Aereas de Espana",
    "AY": "Finnair",
    "LO": "Polish Airlines",
    "EI": "Aer Lingus",
    "LA": "LATAM Airlines",
    "TP": "TAP Portugal",
    "AT": "Royal Air Maroc",
    "WS": "Westjet",
    "HA": "Hawaiian Airlines",
    "PD": "Porter Airlines Canada",
    "TS": "Air Transat",
    "VF": "AJet Hava Tasimaciligi Anonim Sirketi dba Ajet",
    "ME": "Middle Eastern Airlines",
    "GF": "Gulf Air",
    "KM": "KM Malta Airlines Limited",
    "VY": "Vueling Airline SA",
    "A3": "Aegean Airlines",
    "P6": "Privilege Style",
    "CZ": "China Southern",
    "MU": "China Eastern",
    "EY": "Etihad Airways",
    "UL": "SriLankan Airlines",
    "WY": "Oman Air",
    "BR": "Eva Air",
    "CI": "China Airlines",
    "PR": "Philippine Airlines",
    "HX": "Hong Kong Airlines",
    "MK": "Air Mauritius",
    "CA": "Air China",
    "MF": "Shanghai Airlines",
    "MH": "Malaysia Airlines",
    "FM": "Xiamen Air",
    "UO": "Hong Kong Express",
    "TW": "T way Air",
    "7C": "Coyne Airways",
    "SC": "Shadong Airlines",
    "VJ": "Vietjet",
    "LJ": "Jin Air",
    "HB": "Greater Bay Airlines",
    "NX": "Air Macau",
    "QF": "Qantas",
    "HO": "Juneyao Airlines",
    "VN": "Vietnam Airlines",
    "VZ": "Air Express",
    "HU": "Hainan Airlines",
    "OD": "Malindo Airways",
    "3U": "Sichuan Airlines",
    "ZH": "Shenzhen Airlines",
    "JD": "Beijing Capital Airlines",
    "RJ": "Royal Jordanian Airlines",
  };
  return carrierJson[carrierCode] ?? carrierCode;
}

// Airport code mapping
String returnAirportCode(String location) {
  const Map<String, String> locationMap = {
    "Harare": "HRE",
    "Bulawayo": "BUQ",
    "Nairobi": "NBO",
    "Dubai": "DXB",
    "Entebbe": "EBB",
    "Kigali": "KGL",
    "Johannesburg": "JNB",
    "Jo'burg Lanseria": "HLA",
    "Durban": "DUR",
    "Lusaka": "LUN",
    "Doha": "DOH",
    "New York": "JFK",
    "Lilongwe": "LLW",
    "Addis Ababa": "ADD",
    "Amsterdam": "AMS",
    "London": "LHR",
    "Singapore": "SIN",
    "Cape Town": "CPT",
    "Atlanta": "ATL",
    "Sydney": "YQY",
    "Montreal": "YUL",
    "S\u00E3o Paulo": "GRU",
    "Toronto": "YYZ",
    "Toronto Billy Bishop City": "YTZ",
    "Zurich": "ZRH",
    "Cairo": "CAI",
    "Manzini": "SHO",
    "Gaborone": "GBE",
    "Maputo": "MPM",
    "Hong Kong": "HKG",
    "Ho Chi Minh City": "SGN",
    "Tokyo": "TYO",
    "Narita": "NRT",
    "Haneda": "HND",
    "Shanghai": "PVG",
    "Paris": "CDG",
    "Lyon": "LYS",
    "Milan": "BGY",
    "Beijing": "PKX",
    "Los Angeles": "LAX",
    "Washington": "IAX",
    "Chicago": "ORD",
    "Vancouver": "YVR",
    "Mumbai": "BOM",
    "Bangkok": "BKK",
    "Reykjavik": "KEF",
    "Abbotsford Intl": "YXX",
    "Munich": "MUC",
    "Abu Dhabi": "AUH",
    "Colombo": "CMB",
    "Muscat": "MCT",
    "Taipei": "TPE",
    "Seoul": "ICN",
    "Manila": "MNL",
    "Halifax": "YHZ",
    "Mauritius": "MRU",
    "Chengdu": "TFU",
    "Shenzhen": "SZX",
    "Kuala Lumpur": "KUL",
    "Buenos Aires": "BAI",
    "Warsaw": "WAW",
    "Guangzhou": "CAN",
    "Casablanca": "CMN",
    "Osaka": "OSA",
    "Qingdao": "TAO",
    "Osaka Intl (Itami)": "ITM",
    "Macau": "MFM",
    "Kagoshima": "KOJ",
    "Haikou": "HAK",
    "Boston": "BOS",
    "Orlando": "MCO",
    "Nanjing": "NKG",
    "Amman": "AMM",
  };
  return locationMap[location] ?? location;
}

// Airport name mapping
String returnAirportName(String airportCode) {
  const Map<String, String> airportNameMap = {
    "HRE": "R.G. Mugabe Intl.",
    "BUQ": "Joshua M. Nkomo Intl",
    "NBO": "Jomo Kenyatta Intl",
    "DXB": "Dubai Intl.",
    "EBB": "Entebbe Intl.",
    "KGL": "Kigali Intl.",
    "JNB": "Johannesburg",
    // "JNB": "Johannesburg OR Tambo",
    "HLA": "Johannesburg Lanseria",
    "DUR": "King Shaka Intl.",
    "LUN": "Lusaka Intl.",
    "DOH": "Hamad International",
    "JFK": "John F Kennedy Intl",
    "LLW": "Kamuzu Intl",
    "ADD": "Bole Intl",
    "MGQ": "Aden Adde Intl",
    "AMS": "Schiphol Airport",
    "AMW": "Ames Municipal",
    "AME": "Alto Molocue Airport",
    "AMC": "Am Timan Airport",
    "LHR": "London Heathrow",
    "LGW": "London Gatwick",
    "SIN": "Changi",
    "CPT": "Cape Town Intl.",
    "ATL": "Hartsfield-Jackson Int",
    "YQY": "J.A. Douglas McCurdy",
    "YUL": "Pierre E.Trudeau Intl",
    "GRU": "Guarulhos Intl",
    "YYZ": "Lester B. Pearson Intl",
    "ZRH": "Zurich Airport",
    "CAI": "Cairo",
    "SHO": "Manzini",
    "GBE": "Gaborone",
    "MPM": "Maputo",
    "HKG": "Hong Kong",
    "SGN": "Ho Chi Minh City",
    "TYO": "Tokyo",
    "NRT": "Narita",
    "HND": "Haneda",
    "PVG": "Shanghai",
    "CDG": "Paris",
    "LYS": "Lyon",
    "BGY": "Milan",
    "PKX": "Beijing",
    "PEK": "Beijing Capital Intl.",
    "LAX": "Los Angeles",
    "IAD": "Washington Dulles",
    "EWR": "New York Newark",
    "ORD": "Chicago O'Hare",
    "YVR": "Vancouver",
    "BOM": "Mumbai",
    "BKK": "Bangkok",
    "KEF": "Keflavik International",
    "YXX": "Abbotsford Intl.",
    "MUC": "Munich Intl.",
    "BCN": "Josep Tarradellas Barcelona",
    "AUH": "Zayed Intl.",
    "CMB": "Bandaranaike Intl",
    "MCT": "Muscat Intl.",
    "TPE": "Taiwan Taoyuan Intl.",
    "ICN": "Incheon International",
    "MNL": "Ninoy Aquino Intl",
    "MRU": "Sir S. Ramgoolam Intl",
    "TFU": "Tianfu International",
    "SZX": "Bao'an Intl",
    "KUL": "Kuala Lumpur",
    "WAW": "Frederic Chopin",
    "CAN": "Baiyun Intl",
    "CMN": "Mohammed V",
    "KIX": "Kansai International",
    "TAO": "Qingdao",
    "ITM": "Osaka Intl. (Itami)",
    "MFM": "Macau",
    "KOJ": "Kagoshima",
    "HAK": "Haikou",
    "BOS": "Edward L. Logan Intl Boston",
    "LAS": "Harry Reid Intl. Las Vegas",
    "MCO": "Orlando",
    "NKG": "Nanjing",
    "AMM": "Queen Alia Intl",
    "RUH": "King Khalid Intl",
  };
  return airportNameMap[airportCode] ?? airportCode;
}

// City list (for autocomplete suggestion)
List<String> cities = [
  "Harare",
  "Bulawayo",
  "Nairobi",
  "Dubai",
  "Entebbe",
  "Kigali",
  "Johannesburg",
  "Durban",
  "Lusaka",
  "Doha",
  "New York",
  "Lilongwe",
  "Addis Ababa",
  "Amsterdam",
  "London",
  "Singapore",
  "Cape Town",
  "Atlanta",
  "Sydney",
  "Montreal",
  "S\u00E3o Paulo",
  "Toronto",
  "Toronto Billy Bishop City",
  "Zurich",
  "Cairo",
  "Manzini",
  "Gaborone",
  "Maputo",
  "Hong Kong",
  "Ho Chi Minh City",
  "Tokyo",
  "Narita",
  "Haneda",
  "Shanghai",
  "Paris",
  "Lyon",
  "Milan",
  "Beijing",
  "Los Angeles",
  "Washington",
  "Chicago",
  "Vancouver",
  "Mumbai",
  "Bangkok",
  "Frankfurt",
  "Reykyavik",
  "Vancouver",
  "Munich",
  "Barcelona",
  "Abu Dhabi",
  "Colombo",
  "Muscat",
  "Taipei",
  "Seoul",
  "Manila",
  "Halifax",
  "Mauritius",
  "Chengdu",
  "Shenzhen",
  "Kuala Lumpur",
  "Buenos Aires",
  "Warsaw",
  "Guangzhou",
  "Casablanca",
  "Osaka",
  "Qingdao",
  "Macau",
  "Kagoshima",
  "Boston",
  "Las Vegas",
  "Orlando",
  "Amman",
  "Riyadh",
];

// Local city list (for shuttle autocomplete)
List<String> localCities = [
  "Harare",
  "Bulawayo",
  "Mutare",
  "Gweru",
  "Kwekwe",
  "Kadoma",
  "Ruaspe",
  "Masvingo",
  "Victoria Falls",
  "Pretoria",
  "Johannesburg",
  "Durban",
  "Cape Town",
  "Lusaka",
  "Gaborone",
  "Francistown",
  "Maputo",
  "Beira",
  "Tete",
];

// City mapping
String returnLocation(String airportCode) {
  const Map<String, String> airportCodeMap = {
    "HRE": "Harare",
    "BUQ": "Bulawayo",
    "NBO": "Nairobi",
    "DXB": "Dubai",
    "EBB": "Entebbe",
    "KGL": "Kigali",
    "JNB": "Johannesburg",
    "HLA": "Jo'burg Lanseria",
    "DUR": "Durban",
    "LUN": "Lusaka",
    "DOH": "Doha",
    "JFK": "New York",
    "LLW": "Lilongwe",
    "ADD": "Addis Ababa",
    "AMS": "Amsterdam",
    "LHR": "London",
    "SIN": "Singapore",
    "CPT": "Cape Town",
    "ATL": "Atlanta",
    "YQY": "Sydney",
    "YUL": "Montreal",
    "GRU": "S\u00E3o Paulo",
    "YYZ": "Toronto",
    "YTZ": "Toronto Billy Bishop City",
    "ZRH": "Zurich",
    "CAI": "Cairo",
    "SHO": "Manzini",
    "GBE": "Gaborone",
    "MPM": "Maputo",
    "HKG": "Hong Kong",
    "SGN": "Ho Chi Minh City",
    "TYO": "Tokyo",
    "NRT": "Narita",
    "HND": "Haneda",
    "PVG": "Shanghai",
    "CDG": "Paris",
    "LYS": "Lyon",
    "BGY": "Milan",
    "PKX": "Beijing",
    "PEK": "Beijing Capital Intl.",
    "LAX": "Los Angeles",
    "IAX": "Washington",
    "IAD": "Washington Dulles",
    "EWR": "New York Newark",
    "ORD": "Chicago",
    "YVR": "Vancouver",
    "BOM": "Mumbai",
    "BKK": "Bangkok",
    "FRA": "Frankfurt",
    "KEF": "Reykyavik",
    "YXX": "Vancouver",
    "MUC": "Munich",
    "BCN": "Barcelona",
    "AUH": "Abu Dhabi",
    "CMB": "Colombo",
    "MCT": "Muscat",
    "TPE": "Taipei",
    "ICN": "Seoul",
    "MNL": "Manila",
    "YHZ": "Halifax",
    "MRU": "Mauritius",
    "TFU": "Chengdu",
    "SZX": "Shenzhen",
    "KUL": "Kuala Lumpur",
    "BAI": "Buenos Aires",
    "WAW": "Warsaw",
    "CAN": "Guangzhou",
    "CMN": "Casablanca",
    "OSA": "Osaka",
    "KIX": "Kansai Intl.",
    "UKB": "Kobe",
    "TAO": "Qingdao",
    "ITM": "Osaka Intl (Itami)",
    "MFM": "Macau",
    "KOJ": "Kagoshima",
    "HAK": "Haikou",
    "BOS": "Boston",
    "LAS": "Las Vegas",
    "MCO": "Orlando",
    "NKG": "Nanjing",
    "AMM": "Amman",
    "RUH": "Riyadh",
  };
  return airportCodeMap[airportCode] ?? airportCode;
}

String formatDateTime(String isoString) {
  try {
    final dateTime = DateTime.parse(isoString);
    return DateFormat('d MMM yyyy, HH:mm').format(dateTime);
  } catch (e) {
    return isoString;
  }
}

String formatDate(String isoString) {
  try {
    // log(isoString);
    final dateTime = DateTime.parse(isoString);
    return DateFormat('d MMM yyyy').format(dateTime);
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

String getItineraryRouteSummary(List<dynamic> segments) {
  if (segments.isEmpty) return 'No route information';

  final firstSegment = segments.first;
  final lastSegment = segments.last;

  final originCode = firstSegment['departure']['iataCode'];
  final destinationCode = lastSegment['arrival']['iataCode'];

  final origin = returnLocation(originCode);
  final destination = returnLocation(destinationCode);

  return '$origin → $destination';
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
