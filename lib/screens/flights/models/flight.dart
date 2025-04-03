// @collection
import 'dart:convert';
import 'dart:developer';

class Flight {
  String? Id;
  bool? oneWay;
  List<dynamic>? itineraries;
  // String? airline;
  double? price;
  String? currency;

  Flight({
    this.Id,
    this.oneWay,
    this.price,
    this.currency,
    this.itineraries,
    // this.airline,
  });

  factory Flight.fromMap(Map<String, dynamic> json) {
    // log(
    //   'Unpacking flight data from ${JsonEncoder.withIndent(' ').convert(json)}',
    // );
    // light flight;
    try {
      Flight flight = Flight(
        Id: json['id'],
        oneWay: json['oneWay'],
        itineraries: json['itineraries'],
        // airline: json['itineraries']?[0]['segments']?[0]['carrierCode'],
        price: double.parse(json['price']['total']),
        currency: json['price']['currency'],
      );
      // if (json['itineraries'] != null) {}
      log('Flight.fromMap():\n$flight');
      return flight;
    } catch (e) {
      log('Error parsing flights: $e');
      // return Flight;
      return Flight();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'oneWay': oneWay,
      'itineraries': itineraries,
      'price': price,
      'currency': currency,
    };
  }
}

class Itinerary {
  List<dynamic>? segments;
  String? duration;

  Itinerary({this.segments, this.duration});

  factory Itinerary.fromMap(Map<String, dynamic> json) {
    try {
      Itinerary itinerary = Itinerary(
        segments: json['segments'],
        duration: json['duration'],
      );
      log('Itinerary.fromMap():\n$itinerary');
      return itinerary;
    } catch (e) {
      log('Error parsing itineraries: $e');
      // return Flight;
      return Itinerary();
    }
  }

  Map<String, dynamic> toJson() {
    return {'segments': segments, 'duration': duration};
  }
}

class Segment {
  String? departureCode;
  String? arrivalCode;
  String? departureTime;
  String? arrivalTime;
  String? carrierCode;
  String? flightNumber;

  Segment({
    this.departureCode,
    this.arrivalCode,
    this.departureTime,
    this.arrivalTime,
    this.carrierCode,
    this.flightNumber,
  });

  factory Segment.fromMap(Map<String, dynamic> json) {
    try {
      Segment segment = Segment(
        departureCode: json['departureCode'],
        arrivalCode: json['arrivalCode'],
        departureTime: json['departureTime'],
        arrivalTime: json['arrivalTime'],
        carrierCode: json['carrierCode'],
        flightNumber: json['flightNumber'],
      );
      log('Segment.fromMap():\n$segment');
      return segment;
    } catch (e) {
      log('Error parsing segments: $e');
      // return Flight;
      return Segment();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'departureCode': departureCode,
      'arrivalCode': arrivalCode,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'carrierCode': carrierCode,
      'flightNumber': flightNumber,
    };
  }
}
