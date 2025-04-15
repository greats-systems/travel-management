import 'dart:developer';

class ShuttleBooking {
  String? bookingID;
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
        userID: json['user_id'],
        routeID: json['route_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        email: json['email'],
        companyID: json['company_id'],
        companyName: json['ShuttleServiceCompany']['name'],
        origin: json['ShuttleRoutes']['origin'],
        destination: json['ShuttleRoutes']['destination'],
        departureDate: json['departure_date'],
        departureTime: json['ShuttleRoutes']['departure_time'],
        arrivalTime: json['ShuttleRoutes']['arrival_time'],
        amountPaid: (json['amount_paid'] as num).toDouble(),
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
      'amountPaid': amountPaid,
      // 'amount_paid': amountPaid,
    };
  }
}
