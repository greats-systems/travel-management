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
      if (json['data']['activeRideJourney'] != null) {
        Journey journey = Journey(
          userID: json['data']['activeRideJourney']['user_id'] ?? '',
          origin: json['data']['activeRideJourney']['origin'] ?? '',
          destination: json['data']['activeRideJourney']['destination'] ?? '',
          currentLocationLat:
              (json['data']['activeRideJourney']['current_location_lat'] as num)
                  .toDouble(),
          currentLocationLong:
              (json['data']['activeRideJourney']['current_location_long']
                      as num)
                  .toDouble(),
        );
        return journey;
      } else {
        return Journey();
      }
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
