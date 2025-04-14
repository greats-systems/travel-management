// @collection
import 'dart:developer';

class FlightBooking {
  String? bookingID;
  String? createdAt;
  String? amadeusID;
  String? userID;
  String? queueingOfficeID;
  List<dynamic>? itineraries;
  List<dynamic>? travelers;
  Map<String, dynamic>? price;

  FlightBooking({
    this.bookingID,
    this.createdAt,
    this.amadeusID,
    this.userID,
    this.queueingOfficeID,
    this.itineraries,
    this.travelers,
    this.price,
  });

  factory FlightBooking.fromMap(Map<String, dynamic> json) {
    try {
      FlightBooking flightBooking = FlightBooking(
        bookingID: json['booking_id'],
        createdAt: json['created_at'],
        amadeusID: json['amadeus_id'],
        userID: json['user_id'],
        itineraries: json['itineraries'],
        travelers: json['travelers'],
        price: json['price'],
      );
      return flightBooking;
    } catch (e) {
      log('Booking.fromMap error: $e');
      return FlightBooking();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingID': bookingID,
      'amadeusID': amadeusID,
      'userID': userID,
      'itineraries': itineraries,
      'travelers': travelers,
      'price': price,
    };
  }
}
