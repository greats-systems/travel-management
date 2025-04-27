import 'dart:developer';

class ParcelShipment {
  String? id;
  String? createdAt;
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
  String? courierName;
  double? shippingCost;
  String? status;

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
    this.courierName,
    this.shippingCost,
    this.status,
    this.createdAt,
  });

  factory ParcelShipment.fromMap(Map<String, dynamic> json) {
    try {
      ParcelShipment parcelShipment = ParcelShipment(
        id: json['id'],
        createdAt: json['created_at'],
        userId: json['user_id'],
        name: json['name'],
        description: json['description'],
        length: json['length'].toDouble(),
        width: json['width'].toDouble(),
        height: json['height'].toDouble(),
        mass: json['mass_kg'].toDouble(),
        quantity: json['quantity'],
        origin: json['origin'],
        destination: json['destination'],
        departureDate: json['departure_date'],
        companyID: json['shipping_company_id'],
        courierName: json['courier_name'],
        shippingCost: json['shipping_cost'],
        status: json['status'],
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
      'created_at': createdAt,
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
      'courier_name': courierName,
      'shipping_cost': shippingCost,
      'status': status,
    };
  }
}
