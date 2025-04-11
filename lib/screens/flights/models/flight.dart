// @collection

class Flight {
  String? Id;
  bool? oneWay;
  List<dynamic>? itineraries;
  double? price;
  String? currency;
  int? bookableSeats;

  Flight({
    this.Id,
    this.oneWay,
    this.price,
    this.currency,
    this.itineraries,
    this.bookableSeats,
  });

  factory Flight.fromMap(Map<String, dynamic> json) {
    try {
      Flight flight = Flight(
        Id: json['id'],
        bookableSeats: json['numberOfBookableSeats'],
        oneWay: json['oneWay'],
        itineraries: json['itineraries'],
        price: double.parse(json['price']['total']),
        currency: json['price']['currency'],
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
      'price': price,
      'currency': currency,
    };
  }
}
