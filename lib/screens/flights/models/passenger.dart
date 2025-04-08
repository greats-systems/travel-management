class Passenger {
  String? dateOfBirth;
  String? firstName;
  String? lastName;
  String? gender;
  String? phoneNumber;
  String? email;

  Passenger({
    this.dateOfBirth,
    this.firstName,
    this.lastName,
    this.gender,
    this.phoneNumber,
    this.email,
  });

  factory Passenger.fromMap(Map<String, dynamic> json) {
    try {
      Passenger passenger = Passenger(
        dateOfBirth: json['dateOfBirth'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
      );
      return passenger;
    } catch (e) {
      return Passenger();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'dateOfBirth': dateOfBirth,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}
