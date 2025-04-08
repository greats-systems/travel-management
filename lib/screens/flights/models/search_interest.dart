import 'dart:developer';

class SearchInterest {
  String? origin;
  String? destination;
  String? departureDate;
  bool? oneWay;
  String? returnDate;
  int? adults;

  SearchInterest({
    this.origin,
    this.destination,
    this.departureDate,
    this.oneWay,
    this.returnDate,
    this.adults,
  });

  factory SearchInterest.fromMap(Map<String, dynamic> json) {
    try {
      SearchInterest searchInterest = SearchInterest(
        origin: json['origin'],
        destination: json['destination'],
        departureDate: json['departureDate'],
        oneWay: json['oneWay'],
        returnDate: json['returnDate'],
        adults: json['adults'],
      );
      return searchInterest;
    } catch (e) {
      log('SearchInterest.fromMap error: $e');
      return SearchInterest();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'destination': destination,
      'departureDate': departureDate,
      'oneWay': oneWay,
      'returnDate': returnDate,
      'adults': adults,
    };
  }
}
