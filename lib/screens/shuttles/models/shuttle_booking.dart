import 'dart:developer';

class ShuttleBooking {
  String? bookingID;
  String? createdAt;
  String? routeID;
  String? userID;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? companyID;
  String? companyName;
  String? origin;
  String? destination;
  String? departureDate;
  String? departureTime;
  String? arrivalTime;
  double? amountPaid;

  ShuttleBooking({
    this.bookingID,
    this.createdAt,
    this.routeID,
    this.userID,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.companyID,
    this.companyName,
    this.origin,
    this.destination,
    this.departureDate,
    this.departureTime,
    this.arrivalTime,
    this.amountPaid,
  });

  factory ShuttleBooking.fromMap(Map<String?, dynamic> json) {
    try {
      ShuttleBooking shuttleBooking = ShuttleBooking(
        bookingID: json['booking_id'],
        createdAt: json['created_at'],
        userID: json['user_id'],
        routeID: json['route_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        email: json['email'],
        companyID: json['company_id'],
        companyName: json['company_name'],
        origin: json['origin'],
        destination: json['destination'],
        departureDate: json['departure_date'] ?? '',
        departureTime: json['departure_time'] ?? '',
        arrivalTime: json['arrival_time'] ?? '',
        amountPaid: (json['amount_paid']).toDouble(),
      );
      return shuttleBooking;
    } catch (e) {
      log('ShuttleBooking.fromMap error: $e');
      return ShuttleBooking();
    }
  }

  Map<String?, dynamic> toJson() {
    return {
      'bookingID': bookingID,
      'created_at': createdAt,
      'userID': userID,
      'routeID': routeID,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'companyID': companyID,
      'companyName': companyName,
      'origin': origin,
      'destination': destination,
      'departureDate': departureDate,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'amount_paid': amountPaid,
    };
  }
}
