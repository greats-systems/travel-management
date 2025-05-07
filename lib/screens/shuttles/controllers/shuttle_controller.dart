import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/shuttles/models/shuttle.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_booking.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_route.dart';

class ShuttleController {
  final Dio _dio = Dio();

  Future<void> createSearchInterest({
    required String origin,
    required String destination,
    required String departureDate,
    required String userID,
    required double currentLocationLat,
    required double currentLocationLong,
  }) async {
    const url = '${constants.apiRoot}/profile/shuttle-interest/create';

    try {
      final response = await _dio.post(
        url,
        data: {
          'origin': origin,
          'destination': destination,
          'departureDate': departureDate,
          'userID': userID,
          'currentLocationLat': currentLocationLat,
          'currentLocationLong': currentLocationLong,
        },
      );
      log('Search interest created: ${response.data}');
    } on DioException catch (e) {
      log('Failed to create search interest: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('Unexpected error creating search interest: $e');
      rethrow;
    }
  }

  Future<List<Shuttle>> getShuttleCompanies() async {
    const url = '${constants.apiRoot}/shuttles';

    try {
      final response = await _dio.get(url);
      if (response.data is List) {
        return (response.data as List)
            .map((item) => Shuttle.fromMap(item))
            .toList();
      }
      throw FormatException(
        'Expected List but got ${response.data.runtimeType}',
      );
    } on DioException catch (e) {
      log('Failed to fetch shuttle companies: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('Unexpected error fetching shuttle companies: $e');
      rethrow;
    }
  }

  Future<List<ShuttleRoute>> getShuttleRoutes({
    required String origin,
    required String destination,
  }) async {
    const url = '${constants.apiRoot}/shuttle/routes';

    try {
      final response = await _dio.get(
        url,
        data: {
          // Correct for GET requests
          'origin': origin,
          'destination': destination,
        },
        options: Options(
          validateStatus:
              (status) => status! < 500, // Don't throw for server errors
        ),
      );

      // Handle empty responses
      if (response.data == null) {
        return [];
      }

      // Handle successful but empty responses
      if (response.statusCode == 200 &&
          (response.data == null || response.data.isEmpty)) {
        return [];
      }

      // Handle server errors gracefully
      if (response.statusCode! >= 500) {
        log('Server error but treating as empty response');
        return [];
      }

      // Parse successful responses
      if (response.data is List) {
        return (response.data as List)
            .map((item) => ShuttleRoute.fromMap(item))
            .toList();
      }

      log('Unexpected response format: ${response.data.runtimeType}');
      return [];
    } on DioException catch (e) {
      log('Network error: ${e.type} - ${e}');
      return [];
    } catch (e) {
      log('Unexpected error: $e');
      return [];
    }
  }

  Future<List<ShuttleBooking>> getBookingsFromSupabase(String userId) async {
    log(userId);
    final url = '${constants.apiRoot}/shuttle/bookings/$userId';

    try {
      final response = await _dio.get(url, queryParameters: {'userID': userId});
      log(JsonEncoder.withIndent(' ').convert(response.data));

      // Handle case when no bookings exist (returns String)
      if (response.data is String) {
        log('No bookings found: ${response.data}');
        return [];
      }

      // Handle normal case with List response
      if (response.data is List) {
        return (response.data as List)
            .map((item) => ShuttleBooking.fromMap(item))
            .toList();
      }

      throw FormatException(
        'Unexpected response type: ${response.data.runtimeType}',
      );
    } on DioException catch (e) {
      log('Failed to fetch bookings: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('Unexpected error fetching bookings: $e');
      rethrow;
    }
  }

  Future<void> bookShuttle(ShuttleBooking shuttleBooking) async {
    const bookingUrl = '${constants.apiRoot}/shuttle/booking/create';
    const paymentUrl = '${constants.apiRoot}/pay/shuttle/ecocash';

    final bookingData = {
      'userID': shuttleBooking.userID,
      'firstName': shuttleBooking.firstName,
      'lastName': shuttleBooking.lastName,
      'phoneNumber': shuttleBooking.phoneNumber,
      'email': shuttleBooking.email,
      'origin': shuttleBooking.origin,
      'destination': shuttleBooking.destination,
      'departureDate': shuttleBooking.departureDate,
      'departureTime': shuttleBooking.departureTime,
      'arrivalTime': shuttleBooking.arrivalTime,
      'amountPaid': shuttleBooking.amountPaid,
      'companyName': shuttleBooking.companyName,
    };

    final paymentData = {'busFare': shuttleBooking.amountPaid};

    try {
      // Process payment first
      final paymentResponse = await _dio.post(paymentUrl, data: paymentData);
      log('Payment processed: ${jsonEncode(paymentResponse.data)}');

      // Then create booking
      final bookingResponse = await _dio.post(bookingUrl, data: bookingData);
      log('Booking created: ${jsonEncode(bookingResponse.data)}');
    } on DioException catch (e) {
      log('Failed to book shuttle: ${e.response?.data}');
      rethrow;
    } catch (e) {
      log('Unexpected error booking shuttle: $e');
      rethrow;
    }
  }
}
