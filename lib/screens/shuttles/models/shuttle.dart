import 'dart:developer';

class Shuttle {
  String? companyID;
  String? companyName;
  String? address;
  String? phone;
  String? email;

  Shuttle({
    this.companyID,
    this.companyName,
    this.address,
    this.phone,
    this.email,
  });

  factory Shuttle.fromMap(Map<String, dynamic> json) {
    try {
      Shuttle shuttle = Shuttle(
        companyID: json['company_id'],
        companyName: json['name'],
        address: json['address'],
        phone: json['contact_phone'],
        email: json['contact_email'],
      );
      return shuttle;
    } catch (e) {
      log('Shuttle.fromMap error: $e');
      return Shuttle();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'companyID': companyID,
      'companyName': companyName,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}
