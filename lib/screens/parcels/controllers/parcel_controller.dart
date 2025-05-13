import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';

class ParcelController {
  final Dio _dio = Dio();

  // Payment Methods
  Future<void> makeParcelPayment(double cost) async {
    const url = '${constants.apiRoot}/pay/parcel';
    final params = {'total': cost};

    try {
      final response = await _dio.post(url, data: params);
      log(
        'Payment Response: ${JsonEncoder.withIndent(' ').convert(response.data)}',
      );
    } on DioException catch (e) {
      log('Payment Error: ${e.response?.data ?? e.message}', error: e);
      rethrow;
    }
  }

  Future<void> makeParcelEcocashPayment(double cost, String phoneNumber) async {
    const url = '${constants.apiRoot}/pay/parcel/ecocash';
    final params = {
      'cost': cost,
      'phoneNumber':
          phoneNumber.startsWith('0') ? phoneNumber : '0$phoneNumber',
    };

    try {
      final response = await _dio.post(url, data: params);
      log(
        'Ecocash Payment Response: ${JsonEncoder.withIndent(' ').convert(response.data)}',
      );
    } on DioException catch (e) {
      log('Ecocash Payment Error: ${e.response?.data ?? e.message}', error: e);
      rethrow;
    }
  }

  // Shipment Methods
  Future<void> createParcelShipment(ParcelShipment shipment) async {
    const url = '${constants.apiRoot}/parcel-shipments/create';
    final params = {
      'userID': shipment.userId,
      'name': shipment.name,
      'description': shipment.description,
      'length': shipment.length,
      'width': shipment.width,
      'height': shipment.height,
      'mass': shipment.mass,
      'quantity': shipment.quantity,
      'origin': shipment.origin,
      'destination': shipment.destination,
      'courierName': shipment.courierName,
      'departureDate': shipment.departureDate,
      'shippingCost': shipment.shippingCost,
    };

    log('Creating Shipment: ${JsonEncoder.withIndent(' ').convert(params)}');

    try {
      final response = await _dio.post(url, data: params);
      log('Shipment Created: ${response.data}');
    } on DioException catch (e) {
      log(
        'Shipment Creation Error: ${e.response?.data ?? e.message}',
        error: e,
      );
      rethrow;
    }
  }

  // Calculation Methods
  Future<double> calculateDistance({
    required double originLat,
    required double originLong,
    required double destinationLat,
    required double destinationLong,
  }) async {
    const url = '${constants.apiRoot}/parcel-shipments/distance';
    final params = {
      'originLat': originLat,
      'originLong': originLong,
      'destinationLat': destinationLat,
      'destinationLong': destinationLong,
    };

    try {
      final response = await _dio.get(url, data: params);
      return response.data['data']['distance']['kilometers'] as double;
    } on DioException catch (e) {
      log(
        'Distance Calculation Error: ${e.response?.data ?? e.message}',
        error: e,
      );
      rethrow;
    }
  }

  Future<double> calculateShippingCost({
    required Location origin,
    required Location destination,
    required ParcelShipment shipment,
    required double quantity,
  }) async {
    const url = '${constants.apiRoot}/parcel-shipments/cost';
    final params = {
      "length": shipment.length ?? 0.0,
      "width": shipment.width ?? 0.0,
      "height": shipment.height ?? 0.0,
      "mass": shipment.mass ?? 0.0,
      "quantity": quantity,
      "originLat": origin.latitude,
      "originLong": origin.longitude,
      "destinationLat": destination.latitude,
      "destinationLong": destination.longitude,
    };

    log('Calculating Cost: ${params.toString()}');

    try {
      final response = await _dio.post(url, data: params);
      log(response.data.toString());
      return response.data['data']['cost'] as double;
    } on DioException catch (e) {
      log('Cost Calculation Error: ${e.response?.data ?? e.message}', error: e);
      return 0.0; // Fallback value
    }
  }

  // Data Fetching
  Future<List<ParcelShipment>> fetchParcelShipments(String userId) async {
    const url = '${constants.apiRoot}/parcel-shipments';
    final params = {'userID': userId};

    try {
      final response = await _dio.get(url, data: params);
      final List<dynamic> jsonData = response.data;
      return jsonData.map((item) => ParcelShipment.fromMap(item)).toList();
    } on DioException catch (e) {
      log('Fetch Shipments Error: ${e.response?.data ?? e.message}', error: e);
      rethrow;
    }
  }
}
