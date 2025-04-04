import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';

class FlightController {
  Dio dio = Dio();

  Future<List<Flight>> searchForMorePrices(
    // String origin,
    String destination,
    departureDate,
    adults,
  ) async {
    const getFlightPricesURL = 'http://10.0.2.2:5000/prices';
    var params = {
      "origin": "HRE",
      "destination": destination,
      "departureDate": departureDate,
      "adults": adults,
    };
    late List<Flight> flights;

    try {
      log('params: $params');
      await dio.get(getFlightPricesURL, data: params).then((response) {
        log(
          'searchForMorePrices data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
        );
        final List<dynamic> json = response.data;
        flights = json.map((item) => Flight.fromMap(item)).toList();
      });
    } catch (e) {
      if (e is DioException) {
        log('searchForMorePrices DioException: $e');
      } else {
        log('searchForMorePrices error: $e');
      }
    }
    return flights;
  }

  Future<List<Flight>> getFlightPrices() async {
    const getFlightPricesURL = 'http://10.0.2.2:5000/prices';
    const params = {
      "origin": "JNB",
      "destination": "YQY",
      "departureDate": "2025-04-10",
      "adults": 1,
    };
    late List<Flight> flights;
    try {
      await dio.get(getFlightPricesURL, data: params).then((response) {
        log(
          'getFlightPrices data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
        );
        final List<dynamic> json = response.data;
        flights = json.map((item) => Flight.fromMap(item)).toList();
      });
    } catch (e) {
      if (e is DioException) {
        log('getFlightPrices DioException: $e');
      } else {
        log('getFlightPrices error: $e');
      }
    }
    return flights;
  }
}
