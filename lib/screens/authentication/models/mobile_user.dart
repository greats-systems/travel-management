import 'dart:developer';

class MobileUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  String? dob;
  String? licenseClass;
  String? vehicleRegNumber;

  MobileUser({
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

  factory MobileUser.fromMap(Map<String, dynamic> json) {
    try {
      MobileUser user = MobileUser(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phone: json['phone'],
        role: json['role'],
        dob: json['date_of_birth'],
        licenseClass: json['license_class'],
        vehicleRegNumber: json['vehicle_reg_number'],
      );
      return user;
    } catch (e) {
      log('MobileUser.fromMap error: $e');
      return MobileUser();
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
      'date_of_birth': dob,
      'license_class': licenseClass,
      'vehicle_reg_number': vehicleRegNumber,
    };
  }
}
