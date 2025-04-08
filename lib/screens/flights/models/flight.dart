// @collection
import 'dart:developer';

class Flight {
  String? Id;
  bool? oneWay;
  List<dynamic>? itineraries;
  double? price;
  String? currency;

  Flight({this.Id, this.oneWay, this.price, this.currency, this.itineraries});

  factory Flight.fromMap(Map<String, dynamic> json) {
    try {
      Flight flight = Flight(
        Id: json['id'],
        oneWay: json['oneWay'],
        itineraries: json['itineraries'],
        price: double.parse(json['price']['total']),
        currency: json['price']['currency'],
      );
      return flight;
    } catch (e) {
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
