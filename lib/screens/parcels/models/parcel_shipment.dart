import 'dart:developer';

class ParcelShipment {
  String? id;
  String? userId;
  String? name;
  String? description;
  double? length;
  double? width;
  double? height;
  double? mass;
  int? quantity;
  String? origin;
  String? destination;
  String? departureDate;
  String? companyID;
  double? shippingCost;

  ParcelShipment({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.length,
    this.width,
    this.height,
    this.mass,
    this.quantity,
    this.origin,
    this.destination,
    this.departureDate,
    this.companyID,
    this.shippingCost,
  });

  factory ParcelShipment.fromMap(Map<String, dynamic> json) {
    try {
      ParcelShipment parcelShipment = ParcelShipment(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        description: json['description'],
        length: double.parse(json['length']),
        width: double.parse(json['width']),
        height: double.parse(json['height']),
        mass: double.parse(json['mass_kg']),
        quantity: int.parse(json['quantity']),
        origin: json['origin'],
        destination: json['destination'],
        departureDate: json['departure_date'],
        companyID: json['shipping_company_id'],
        shippingCost: double.parse(json['shipping_cost']),
      );
      return parcelShipment;
    } catch (e) {
      log('ParcelShipment.fromMap error: $e');
      return ParcelShipment();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'description': description,
      'length': length,
      'width': width,
      'height': height,
      'mass_kg': mass,
      'quantity': quantity,
      'origin': origin,
      'destination': destination,
      'departure_date': departureDate,
      'shipping_company_id': companyID,
      'shipping_cost': shippingCost,
    };
  }
}
