import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/shuttles/models/ride.dart';
import 'package:travel_management_app_2/screens/shuttles/models/ride_booking.dart';

class RideController {
  Dio dio = Dio();

  Future<List<Ride>> getRides(String origin, String destination) async {
    const ridesURL = '${constants.apiRoot}/rides';

    try {
      final response = await dio.get(
        ridesURL,
        data: {'origin': origin, 'destination': destination},
      );

      log('API Response: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        if (data['data'] != null) {
          final ridesList = data['data'] as List;
          return ridesList.map((rideJson) => Ride.fromMap(rideJson)).toList();
        } else {
          log('No rides data found in response');
          return [];
        }
      } else {
        log('API Error: ${response.statusCode} - ${response.statusMessage}');
        return [];
      }
    } on DioException catch (e) {
      log('Dio Error: ${e.message}');
      if (e.response != null) {
        log('Response data: ${e.response?.data}');
        log('Status code: ${e.response?.statusCode}');
      }
      return [];
    } catch (e) {
      log('Unexpected Error: $e');
      return [];
    }
  }

  Future<List<RideBooking>?> getBookingsFromSupabase(String userId) async {
    var params = {'userID': userId};
    const bookingsURL = '${constants.apiRoot}/shuttle/bookings';
    List<RideBooking> bookings = [];

    await dio
        .get(bookingsURL, data: params)
        .then((response) {
          final List<dynamic> json = response.data;
          bookings = json.map((item) => RideBooking.fromMap(item)).toList();
        })
        .catchError((e) {
          if (e is DioException) {
            log('getBookingsFromSupabase DioException: ${e.response}');
          } else {
            log('getBookingsFromSupabase error: $e');
          }
        });
    return bookings;
  }

  Future<void> bookRide(RideBooking shuttleBooking) async {
    const shuttleBookingURL = '${constants.apiRoot}/shuttle/booking/create';
    const paynowURL = '${constants.apiRoot}/pay/shuttle/ecocash';
    var params = {};
    var paynowParams = {'rideFare': shuttleBooking.amountPaid};

    // Post transactions into Paynow
    await dio
        .post(paynowURL, data: paynowParams)
        .then((response) {
          log(
            'Paynow response: ${JsonEncoder.withIndent(' ').convert(response.data)}',
          );
          return response;
        })
        .catchError((e) {
          if (e is DioException) {
            log('bookRide DioException: ${e.response}');
            return e.response!;
          } else {
            log('bookRide error: $e');
            return e;
          }
        });

    // Post transaction into Supabase
    await dio
        .post(shuttleBookingURL, data: params)
        .then((response) {
          log('bookRide supabase response: $response');
          return response;
        })
        .catchError((e) {
          if (e is DioException) {
            log('bookRide supabase DioException: ${e.response}');
            return e.response!;
          } else {
            log('bookRide supabase error: $e');
            return e;
          }
        });
  }
}
