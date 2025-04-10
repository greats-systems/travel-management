import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/flights/models/passenger.dart';

class FlightController {
  Dio dio = Dio();

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
      await dio
          .get(getFlightPricesURL, data: params)
          .then((response) {
            final List<dynamic> json = response.data;
            // log('getFlightPrices response: ${response.data}');
            flights = json.map((item) => Flight.fromMap(item)).toList();
          })
          // ignore: argument_type_not_assignable_to_error_handler
          .catchError((DioException e) {
            if (e.response!.statusCode == 404) {
              log(e.toString());
            }
          });
    } catch (e) {
      if (e is DioException) {
        log('searchForMorePrices DioException: ${e.message}');
      } else {
        log('searchForMorePrices error: $e');
      }
    }
    return flights;
  }

  void createBookingInSupabase(amadeusResponse, id) async {
    final bookingURL = '${constants.apiRoot}/flight/booking/create';
    var params = {
      'amadeusID': amadeusResponse['id'],
      'userID': id,
      'queueingOfficeId': amadeusResponse['queuingOfficeId'],
      'itineraries': amadeusResponse['flightOffers'][0]['itineraries'],
      'travelers': amadeusResponse['travelers'],
      'price': amadeusResponse['flightOffers'][0]['price'],
    };

    await dio.post(bookingURL, data: params).then((response) {
      log('createBookingInSupabase data: ${response.data}');
    });
  }

  Future<List<Booking>> getBookingsFromSupabase(id) async {
    final bookingsURL = '${constants.apiRoot}/flight/bookings';
    List<Booking> bookings = [];
    var params = {'userID': id};

    try {
      await dio.get(bookingsURL, data: params).then((response) {
        // log(
        //   'getBookingFromSupabase data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
        // );
        final List<dynamic> json = response.data;
        bookings = json.map((item) => Booking.fromMap(item)).toList();
        // log('Bookings: ${JsonEncoder.withIndent(' ').convert(bookings)}');
      });
    } catch (e) {
      if (e is DioException) {
        log('getBookingFromSupabase DioException: ${e.message}');
      } else {
        log('getBookingFromSupabase error: $e');
      }
    }
    return bookings;
  }

  Future<Map<String, dynamic>> bookFlight(
    String id,
    String origin,
    String destination,
    String departureDate,
    String? returnDate,
    int adults, // Keep adults count for validation
    List<Passenger> passengers,
    Flight flight,
  ) async {
    const flightBookingURL = '${constants.apiRoot}/flight/book';

    // Validate passenger count matches adults count
    if (passengers.length != adults) {
      throw Exception(
        'Passenger count ${passengers.length} must match adults count ($adults)',
      );
    }

    // Convert passengers to SDK format
    final sdkPassengers =
        passengers.asMap().entries.map((entry) {
          final index = entry.key + 1; // 1-based ID
          final p = entry.value;
          return {
            "id": "$index",
            "dateOfBirth": p.dateOfBirth,
            "name": {
              "firstName": p.firstName!.toUpperCase(),
              "lastName": p.lastName!.toUpperCase(),
            },
            "gender": p.gender!.toUpperCase(),
            "contact": {
              "emailAddress": p.email,
              "phones": [
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "263", // Zimbabwe code
                  "number": p.phoneNumber,
                },
              ],
            },
          };
        }).toList();

    final params = {
      "origin": origin,
      "destination": destination,
      "departureDate": departureDate,
      "adults": adults,
      "flightId": "${flight.Id}",
      "passengers": sdkPassengers, // Direct array of passengers
    };

    if (returnDate != null) {
      params["returnDate"] = returnDate;
    }

    log('Booking Request: ${JsonEncoder.withIndent('  ').convert(params)}');

    try {
      final response = await dio.post(flightBookingURL, data: params);
      final json = response.data;
      // log('Booking Success: ${JsonEncoder.withIndent(' ').convert(json)}');
      // return response.data;
      createBookingInSupabase(json, id);
      return json;
    } on DioException catch (e) {
      log('Booking Failed: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
