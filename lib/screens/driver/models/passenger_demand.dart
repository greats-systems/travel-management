import 'dart:developer';

class PassengerDemand {
  String? firstName;
  String? lastName;
  String? origin;
  String? destination;
  String? departureDate;

  PassengerDemand({
    this.firstName,
    this.lastName,
    this.origin,
    this.destination,
    this.departureDate,
  });

  factory PassengerDemand.fromJson(Map<String, dynamic> json) {
    try {
      PassengerDemand demand = PassengerDemand(
        firstName: json['Profiles']['first_name'],
        lastName: json['Profiles']['last_name'],
        origin: json['origin'],
        destination: json['destination'],
        departureDate: json['departureDate'],
      );
      return demand;
    } catch (e) {
      log('PassengerDemand.fromJson error: $e');
      return PassengerDemand();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'origin': origin,
      'destination': destination,
      'departureDate': departureDate,
    };
  }
}
