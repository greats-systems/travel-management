import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:travel_management_app_2/screens/flights/models/booking.dart';
import 'package:travel_management_app_2/screens/flights/models/flight.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/flights/models/passenger.dart';

class FlightController {
  final Dio _dio;
  final Connectivity _connectivity;
  static final _apiRoot = constants.apiRoot;

  FlightController({Dio? dio, Connectivity? connectivity})
    : _dio = dio ?? Dio(),
      _connectivity = connectivity ?? Connectivity();

  // API Endpoints
  static String get _createSearchInterestUrl =>
      '$_apiRoot/profile/flight-interest/create';
  static String get _flightPricesUrl => '$_apiRoot/flight/prices';
  static String get _createBookingUrl => '$_apiRoot/flight/booking/create';
  static String get _bookingsUrl => '$_apiRoot/flight/bookings';
  static String get _flightBookingUrl => '$_apiRoot/flight/book';

  Future<void> _checkInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkException('No internet connection available');
    }
  }

  Future<void> createSearchInterest({
    required String userID,
    required String origin,
    required String destination,
    required String departureDate,
    required bool oneWay,
    required int adults,
    String? returnDate,
    double? currentLocationLat,
    double? currentLocationLong,
  }) async {
    log('createSearchInterest userId: $userID');
    try {
      final response = await _dio.post(
        _createSearchInterestUrl,
        data: {
          'origin': origin,
          'destination': destination,
          'departureDate': departureDate,
          'oneWay': oneWay,
          'returnDate': returnDate,
          'adults': adults,
          'userID': userID,
          'currentLocationLat': currentLocationLat,
          'currentLocationLong': currentLocationLong,
        },
      );
      log('Search interest created: ${response.data}');
    } on DioException catch (e) {
      log('Failed to create search interest: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  Future<List<Flight>> getFlightPrices({
    required String origin,
    required String destination,
    required String departureDate,
    String? returnDate,
    int adults = 1, // Default value
    String? travelClass,
  }) async {
    try {
      await _checkInternetConnection();

      final params = {
        'origin': origin,
        'destination': destination,
        'departureDate': departureDate,
        if (returnDate != null) 'returnDate': returnDate,
        'adults': adults,
        if (travelClass != null) 'travelClass': travelClass,
      };

      log('Fetching flight prices with params: $params');

      final response = await _dio.post(
        // Changed to POST
        _flightPricesUrl,
        data: params,
        options: Options(
          receiveTimeout: const Duration(seconds: 60),
          headers: {'Content-Type': 'application/json'},
        ),
      );

      final data = response.data;
      if (data is! List) {
        throw FormatException('Expected List but got ${data.runtimeType}');
      }

      return data.map((item) => Flight.fromMap(item)).toList();
    } on DioException catch (e) {
      log('Failed to get flight prices: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  Future<void> createBookingInSupabase({
    required Map<String, dynamic> amadeusResponse,
    required String id,
    required String departureDate,
  }) async {
    final params = {
      'amadeusID': amadeusResponse['booking']['id'],
      'userID': id,
      'queueingOfficeId': amadeusResponse['booking']['queuingOfficeId'],
      'itineraries':
          amadeusResponse['booking']['flightOffers'][0]['itineraries'],
      'travelers': amadeusResponse['booking']['travelers'],
      'price': amadeusResponse['booking']['flightOffers'][0]['price'],
      'departureDate': departureDate,
    };
    try {
      final response = await _dio.post(_createBookingUrl, data: params);
      log(
        'Booking created in Supabase: ${JsonEncoder.withIndent(' ').convert(response.data)}',
      );
      // return response.data;
    } on DioException catch (e) {
      log('Failed to create booking: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  Future<List<FlightBooking>> getBookingsFromSupabase(String userId) async {
    try {
      final response = await _dio.get(
        '$_bookingsUrl/$userId',
        queryParameters: {'userID': userId},
      );

      if (response.data is! List) {
        if (response.data is String) {
          return []; // Return empty list for "no bookings" message
        }
        throw FormatException(
          'Expected List but got ${response.data.runtimeType}',
        );
      }

      return (response.data as List)
          .map((item) => FlightBooking.fromMap(item))
          .toList();
    } on DioException catch (e) {
      log('Failed to get bookings: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> bookFlight({
    required String userId,
    required String origin,
    required String destination,
    required String departureDate,
    required int adults,
    required List<Passenger> passengers,
    required Flight flight,
    required String callingCode,
    String? returnDate,
  }) async {
    try {
      // Validate passenger count
      if (passengers.length != adults) {
        throw ArgumentError(
          'Passenger count (${passengers.length}) must match adults count ($adults)',
        );
      }

      // Prepare passenger data
      final sdkPassengers =
          passengers.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final passenger = entry.value;

            return {
              'id': '$index',
              'dateOfBirth': passenger.dateOfBirth,
              'name': {
                'firstName': passenger.firstName?.toUpperCase(),
                'lastName': passenger.lastName?.toUpperCase(),
              },
              'gender': passenger.gender?.toUpperCase(),
              'contact': {
                'emailAddress': passenger.email,
                'phones': [
                  {
                    'deviceType': 'MOBILE',
                    'countryCallingCode': callingCode.replaceAll('+', ''),
                    'number': _formatPhoneNumber(
                      passenger.phoneNumber!,
                      callingCode,
                    ),
                  },
                ],
              },
            };
          }).toList();

      // Prepare request payload
      final payload = {
        'origin': origin,
        'destination': destination,
        'departureDate': departureDate,
        'adults': adults,
        'flightId': flight.Id.toString(),
        'passengers': sdkPassengers,
        if (returnDate != null) 'returnDate': returnDate,
      };

      final response = await _dio.post(_flightBookingUrl, data: payload);
      final responseData = response.data;
      log(
        'Amadeus response: ${JsonEncoder.withIndent(' ').convert(responseData)}',
      );

      // Save booking to Supabase

      await createBookingInSupabase(
        amadeusResponse: responseData,
        id: userId,
        departureDate: departureDate,
      );

      return responseData;
    } on DioException catch (e) {
      log('Flight booking failed: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  String _formatPhoneNumber(String phoneNumber, String countryCode) {
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    final cleanCountryCode = countryCode.replaceAll(RegExp(r'[^\d+]'), '');

    if (digitsOnly.startsWith('0')) {
      return digitsOnly.substring(1);
    }

    if (digitsOnly.startsWith(cleanCountryCode.replaceAll('+', ''))) {
      return digitsOnly.substring(cleanCountryCode.replaceAll('+', '').length);
    }

    return digitsOnly;
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}
