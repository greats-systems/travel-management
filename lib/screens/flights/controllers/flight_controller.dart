import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class FlightController {
  Dio dio = Dio();
  // static const root = 'http://10.0.2.2:5000';

  Future<List<Flight>> getFlightPrices(
    origin,
    destination,
    departureDate,
    returnDate,
    adults,
  ) async {
    const getFlightPricesURL = '${constants.apiRoot}/flight/prices';
    Map<String, dynamic> params;
    if (returnDate != null) {
      params = {
        "origin": origin,
        "destination": destination,
        "departureDate": departureDate,
        "returnDate": returnDate,
        "adults": adults,
      };
    } else {
      params = {
        "origin": origin,
        "destination": destination,
        "departureDate": departureDate,
        "returnDate": null,
        "adults": adults,
      };
    }
    late List<Flight> flights;

    try {
      log('params: $params');
      await dio.get(getFlightPricesURL, data: params).then((response) {
        // log(
        //   'searchForMorePrices data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
        // );
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

  void bookFlight(
    String origin,
    String destination,
    String departureDate,
    String? returnDate,
    int adults,
    String dob,
    String firstname,
    String lastname,
    String gender,
    String phone,
    String email,
    Flight flight,
  ) async {
    const flightBookingURL = '${constants.apiRoot}/flight/book';
    var params = {
      "origin": origin,
      "destination": destination,
      "departureDate": departureDate,
      "adults": adults,
      "flightId": "${flight.Id}",
      "passengers": {
        "id": "1",
        "dateOfBirth": dob,
        "name": {
          "firstName": firstname.toUpperCase(),
          "lastName": lastname.toUpperCase(),
        },
        "gender": gender.toUpperCase(),
        "contact": {
          "emailAddress": email,
          "phones": [
            {
              "deviceType": "MOBILE",
              "countryCallingCode": "263",
              "number": phone,
            },
          ],
        },
      },
    };
    log('Params: ${JsonEncoder.withIndent(' ').convert(params)}');
    try {
      await dio.post(flightBookingURL, data: params).then((response) {
        log(
          'bookFlight data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
        );
      });
    } catch (error) {
      if (error is DioException) {
        log('bookFlight DioException: ${error.response}');
      } else {
        log('bookFlight error: $error');
      }
    }
    return;
  }
}
