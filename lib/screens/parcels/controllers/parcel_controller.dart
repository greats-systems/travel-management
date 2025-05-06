import 'dart:convert';

import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:dio/dio.dart';
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';
import 'dart:developer';

class ParcelController {
  Dio dio = Dio();

  Future<void> makeParcelPayment(double cost) async {
    const makeParcelPaymentURL = '${constants.apiRoot}/pay/parcel';
    var params = {'total': cost};

    await dio
        .post(makeParcelPaymentURL, data: params)
        .then((response) {
          log(JsonEncoder.withIndent(' ').convert(response.data));
        })
        .catchError((e) {
          if (e is DioException) {
            log('makeParcelPayment DioException: ${e.response}');
          } else {
            log('makeParcelPayment error: $e');
          }
        });
  }

  Future<void> makeParcelEcocashPayment(double cost, String phoneNumber) async {
    const makeParcelEcocashPaymentURL =
        '${constants.apiRoot}/pay/parcel/ecocash';
    var params = {'cost': cost, 'phoneNumber': '0$phoneNumber'};

    await dio
        .post(makeParcelEcocashPaymentURL, data: params)
        .then((response) {
          log(JsonEncoder.withIndent(' ').convert(response.data));
        })
        .catchError((e) {
          if (e is DioException) {
            log('makeParcelEcocashPayment DioException: ${e.response}');
          } else {
            log('makeParcelEcocashPayment error: $e');
          }
        });
  }

  Future<void> createParcelShipment(ParcelShipment parcelShipment) async {
    const createParcelShipmentURL =
        '${constants.apiRoot}/parcel-shipments/create';
    var params = {
      'userID': parcelShipment.userId,
      'name': parcelShipment.name,
      'description': parcelShipment.description,
      'length': parcelShipment.length,
      'width': parcelShipment.width,
      'height': parcelShipment.height,
      'mass': parcelShipment.mass,
      'quantity': parcelShipment.quantity,
      'origin': parcelShipment.origin,
      'destination': parcelShipment.destination,
      'courierName': parcelShipment.courierName,
      'departureDate': parcelShipment.departureDate,
      'shippingCost': parcelShipment.shippingCost,
    };

    log(JsonEncoder.withIndent(' ').convert(params));

    await dio
        .post(createParcelShipmentURL, data: params)
        .then((response) {
          log(response.data);
        })
        .catchError((e) {
          if (e is DioException) {
            log('createParcelShipment DioException: ${e.response}');
          } else {
            log('createParcelShipment error: $e');
          }
        });
  }

  Future<double> calculateDistance(
    double originLat,
    double originLong,
    double destinationLat,
    double destinationLong,
  ) async {
    const calculateDistanceURL = '${constants.apiRoot}/distance';
    var params = {
      'originLat': originLat,
      'originLong': originLong,
      'destinationLat': destinationLat,
      'destinationLong': destinationLong,
    };
    late double distanceKm;

    await dio
        .get(calculateDistanceURL, data: params)
        .then((response) {
          final Map<String, dynamic> json = response.data;
          distanceKm = json['distance']['kilometers'];
        })
        .catchError((e) {
          if (e is DioException) {
            log('calculateDistance DioException: ${e.response}');
          } else {
            log('calculateDistance error: $e');
          }
        });
    return distanceKm;
  }

  Future<List<ParcelShipment>?> viewParcelShipments(String userId) async {
    const viewParcelShipmentsURL = '${constants.apiRoot}/parcel-shipments';
    var params = {'userID': userId};
    late List<ParcelShipment>? parcelShipments;

    await dio
        .get(viewParcelShipmentsURL, data: params)
        .then((response) {
          final List<dynamic> json = response.data;
          parcelShipments =
              json.map((item) => ParcelShipment.fromMap(item)).toList();
          log(
            'parcelShipments ${JsonEncoder.withIndent(' ').convert(parcelShipments)}',
          );
        })
        .catchError((e) {
          if (e is DioException) {
            log('viewParcelShipment DioException: ${e.response}');
          } else {
            log('vParcelShipment error: $e');
          }
        });
    return parcelShipments;
  }
}
