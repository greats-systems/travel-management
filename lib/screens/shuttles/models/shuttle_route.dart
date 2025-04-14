import 'dart:developer';

class ShuttleRoute {
  String? companyID;
  String? routeID;
  String? origin;
  String? destination;
  String? departureTime;
  String? arrivalTime;
  List<dynamic>? busStops;
  Map<String, dynamic>? shuttleServiceCompany;
  double? price;

  ShuttleRoute({
    this.companyID,
    this.routeID,
    this.origin,
    this.destination,
    this.departureTime,
    this.arrivalTime,
    this.busStops,
    this.shuttleServiceCompany,
    this.price,
  });

  factory ShuttleRoute.fromMap(Map<String, dynamic> json) {
    try {
      ShuttleRoute route = ShuttleRoute(
        companyID: json['company_id'],
        routeID: json['route_id'],
        origin: json['origin'],
        destination: json['destination'],
        departureTime: json['departure_time'],
        arrivalTime: json['arrival_time'],
        busStops: json['bus_stops'],
        shuttleServiceCompany: json['ShuttleServiceCompany'],
        price: (json['price'] as num?)?.toDouble(),
      );
      return route;
    } catch (e) {
      log('Route.fromMap error: $e');
      return ShuttleRoute();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'companyID': companyID,
      'routeID': routeID,
      'origin': origin,
      'destination': destination,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'busStops': busStops,
      'ShuttleServiceCompany': shuttleServiceCompany,
      'price': price,
    };
  }
}
