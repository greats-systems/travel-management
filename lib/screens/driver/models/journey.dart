import 'dart:developer';

class Journey {
  String? userID;
  String? origin;
  String? destination;
  double? currentLocationLat;
  double? currentLocationLong;

  Journey({
    this.userID,
    this.origin,
    this.destination,
    this.currentLocationLat,
    this.currentLocationLong,
  });

  factory Journey.fromMap(Map<String, dynamic> json) {
    try {
      Journey journey = Journey(
        userID: json['data'][0]['user_id'],
        origin: json['data'][0]['origin'],
        destination: json['data'][0]['destination'],
        currentLocationLat: json['data'][0]['current_location_lat'],
        currentLocationLong: json['data'][0]['current_location_long'],
      );
      return journey;
    } catch (e) {
      log('Journey.fromMap error $e');
      if (e is RangeError) {
        return Journey();
      } else {
        return Journey();
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userID,
      'origin': origin,
      'destination': destination,
      'current_location_lat': currentLocationLat,
      'current_location_long': currentLocationLong,
    };
  }
}
