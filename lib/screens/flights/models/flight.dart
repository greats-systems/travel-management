// @collection

import 'dart:convert';
import 'dart:developer';

class Flight {
  String? Id;
  bool? oneWay;
  List<dynamic>? itineraries;
  List<dynamic>? travelerPricings;
  double? price;
  String? currency;
  int? bookableSeats;

  Flight({
    this.Id,
    this.oneWay,
    this.price,
    this.currency,
    this.itineraries,
    this.travelerPricings,
    this.bookableSeats,
  });

  factory Flight.fromMap(Map<String, dynamic> json) {
    try {
      Flight flight = Flight(
        Id: json['id'],
        bookableSeats: json['numberOfBookableSeats'],
        oneWay: json['oneWay'],
        travelerPricings: json['travelerPricings'],
        itineraries: json['itineraries'],
        price: double.parse(json['price']['total']),
        currency: json['price']['currency'],
      );
      log(
        'Flight.fromMap data: ${JsonEncoder.withIndent(' ').convert(flight.toJson()['travelerPricings'][0]['fareDetailsBySegment'][0]['cabin'])}',
      );
      return flight;
    } catch (e) {
      return Flight(bookableSeats: 0);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'oneWay': oneWay,
      'itineraries': itineraries,
      'travelerPricings': travelerPricings,
      'price': price,
      'currency': currency,
    };
  }
}
