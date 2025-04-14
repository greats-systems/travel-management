import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/flights/models/passenger.dart';

class FlightController {
  Dio dio = Dio();

  Future<List<Flight>?> getFlightPrices(
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
    late List<Flight>? flights;

    try {
      log('params: $params');
      await dio
          .get(getFlightPricesURL, data: params)
          .then((response) {
            final List<dynamic> json = response.data;
            // log('json: ${JsonEncoder.withIndent(' ').convert(json)}');
            flights = json.map((item) => Flight.fromMap(item)).toList();
            // log('flights are ready to view');
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

  void createBookingInSupabase(amadeusResponse, id, departureDate) async {
    final bookingURL = '${constants.apiRoot}/flight/booking/create';
    var params = {
      'amadeusID': amadeusResponse['id'],
      'userID': id,
      'queueingOfficeId': amadeusResponse['queuingOfficeId'],
      'itineraries': amadeusResponse['flightOffers'][0]['itineraries'],
      'travelers': amadeusResponse['travelers'],
      'price': amadeusResponse['flightOffers'][0]['price'],
      'departureDate': departureDate,
    };

    await dio.post(bookingURL, data: params).then((response) {
      log('createBookingInSupabase data: ${response.data}');
    });
  }

  Future<List<FlightBooking>> getBookingsFromSupabase(id) async {
    final bookingsURL = '${constants.apiRoot}/flight/bookings';
    List<FlightBooking> bookings = [];
    var params = {'userID': id};

    try {
      await dio.get(bookingsURL, data: params).then((response) {
        // log(
        //   'getBookingFromSupabase data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
        // );
        final List<dynamic> json = response.data;
        bookings = json.map((item) => FlightBooking.fromMap(item)).toList();
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
    int adults,
    List<Passenger> passengers,
    Flight flight,
    String callingCode, // Now properly used for each passenger
  ) async {
    const flightBookingURL = '${constants.apiRoot}/flight/book';

    // Validate passenger count matches adults count
    if (passengers.length != adults) {
      throw Exception(
        'Passenger count ${passengers.length} must match adults count ($adults)',
      );
    }

    // Convert passengers to SDK format with proper phone formatting
    final sdkPassengers =
        passengers.asMap().entries.map((entry) {
          final index = entry.key + 1; // 1-based ID
          final p = entry.value;

          // Validate and format phone number
          final formattedPhone = _formatPhoneNumber(
            p.phoneNumber!,
            callingCode,
          );

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
                  "countryCallingCode": callingCode.replaceAll(
                    '+',
                    '',
                  ), // Remove + if present
                  "number": '0$formattedPhone',
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
      "passengers": sdkPassengers,
    };

    if (returnDate != null) {
      params["returnDate"] = returnDate;
    }

    log('Booking Request: ${JsonEncoder.withIndent('  ').convert(params)}');

    try {
      final response = await dio.post(flightBookingURL, data: params);
      final json = response.data;
      createBookingInSupabase(json, id, departureDate);
      return json;
    } on DioException catch (e) {
      log('Booking Failed: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  // Helper method to format phone numbers
  String _formatPhoneNumber(String phoneNumber, String countryCode) {
    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Remove leading zero if present for international format
    if (digitsOnly.startsWith('0')) {
      return digitsOnly.substring(1);
    }

    // If country code is already included in the number, remove it
    final cleanCountryCode = countryCode
        .replaceAll('+', '')
        .replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.startsWith(cleanCountryCode)) {
      return digitsOnly.substring(cleanCountryCode.length);
    }

    return digitsOnly;
  }
}
