import 'dart:developer';

class MobileDriver {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  String? dob;
  String? licenseClass;
  String? vehicleRegNumber;

  MobileDriver({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.dob,
    this.licenseClass,
    this.vehicleRegNumber,
  });

  factory MobileDriver.fromMap(Map<String, dynamic> json) {
    try {
      MobileDriver user = MobileDriver(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phone: json['phone'],
        role: json['role'],
      );
      return user;
    } catch (e) {
      log('MobileDriver.fromMap error: $e');
      return MobileDriver();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'role': role,
    };
  }
}
