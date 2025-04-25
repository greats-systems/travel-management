import 'dart:developer';

class ShippingCompany {
  String? name;
  String? address;
  String? phone;
  String? email;

  ShippingCompany({this.name, this.address, this.email, this.phone});

  factory ShippingCompany.fromMap(Map<String, dynamic> json) {
    try {
      ShippingCompany shippingCompany = ShippingCompany(
        name: json['name'],
        address: json['address'],
        phone: json['phone'],
        email: json['email'],
      );
      return shippingCompany;
    } catch (e) {
      log('ShippingCompany.fromMap error: $e');
      return ShippingCompany();
    }
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address, 'phone': phone, 'email': email};
  }
}
