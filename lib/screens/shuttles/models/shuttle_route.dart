import 'dart:developer';

class ShuttleRoute {
  String? comapnyID;
  String? origin;
  String? destination;
  String? departureTime;
  String? arrivalTime;
  List<dynamic>? busStops;

  ShuttleRoute({
    this.comapnyID,
    this.origin,
    this.destination,
    this.departureTime,
    this.arrivalTime,
    this.busStops,
  });

  factory ShuttleRoute.fromMap(Map<String, dynamic> json) {
    try {
      ShuttleRoute route = ShuttleRoute(
        comapnyID: json['company_id'],
        origin: json['origin'],
        destination: json['destination'],
        departureTime: json['departure_time'],
        arrivalTime: json['arrival_time'],
        busStops: json['bus_stops'],
      );
      return route;
    } catch (e) {
      log('Route.fromMap error: $e');
      return ShuttleRoute();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'companyID': comapnyID,
      'origin': origin,
      'destination': destination,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'busStops': busStops,
    };
  }
}
