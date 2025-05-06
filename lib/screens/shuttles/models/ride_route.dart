import 'dart:developer';

class RideRoute {
  String? driverID;
  String? status;
  double? driverPositionLat;
  double? driverPositionLong;
  String? origin;
  String? destination;

  RideRoute({
    this.driverID,
    this.status,
    this.driverPositionLat,
    this.driverPositionLong,
    this.origin,
    this.destination,
  });

  factory RideRoute.fromMap(Map<String, dynamic> json) {
    try {
      RideRoute journey = RideRoute(
        driverID: json['user_id'],
        driverPositionLat: json['current_location_lat'],
        driverPositionLong: json['current_location_long'],
        origin: json['origin'],
        destination: json['destination'],
      );
      return journey;
    } catch (e) {
      log('RideRoute.fromMap error $e');
      return RideRoute();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'destination': destination,
      'current_location_lat': driverPositionLat,
      'current_location_long': driverPositionLong,
    };
  }
}
