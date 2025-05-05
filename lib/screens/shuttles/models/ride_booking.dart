import 'dart:developer';

class RideBooking {
  String? userID;
  String? driverID;
  String? origin;
  String? destination;
  double? amountPaid;

  RideBooking({
    this.userID,
    this.driverID,
    this.origin,
    this.destination,
    this.amountPaid,
  });

  factory RideBooking.fromMap(Map<String, dynamic> json) {
    try {
      RideBooking booking = RideBooking(
        userID: json['user_id'],
        driverID: json['driver_id'],
        origin: json['origin'],
        destination: json['destination'],
        amountPaid: (json['amount_paid'] as num).toDouble(),
      );
      return booking;
    } catch (e) {
      log('RideBooking.fromJson error: $e');
      return RideBooking();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userID,
      'driver_id': driverID,
      'origin': origin,
      'destination': destination,
      'amount_paid': amountPaid,
    };
  }
}
