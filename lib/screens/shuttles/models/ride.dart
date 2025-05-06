import 'dart:convert';
import 'dart:developer';

class Ride {
  String? driverID;
  double? driverPositionLat;
  double? driverPositionLong;

  Ride({this.driverID, this.driverPositionLat, this.driverPositionLong});

  factory Ride.fromMap(Map<String, dynamic> json) {
    try {
      Ride ride = Ride(
        driverID: json['user_id'],
        driverPositionLat: (json['current_location_lat'] as num).toDouble(),
        driverPositionLong: (json['current_location_long'] as num).toDouble(),
      );
      log('Ride.fromMap data: ${JsonEncoder.withIndent(' ').convert(ride)}');
      return ride;
    } catch (e) {
      log('Ride.fromMap error $e');
      return Ride();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'driver_id': driverID,
      'current_location_lat': driverPositionLat,
      'current_location_long': driverPositionLong,
    };
  }
}
