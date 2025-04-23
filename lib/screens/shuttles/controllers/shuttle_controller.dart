import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_booking.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_route.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class ShuttleController {
  Dio dio = Dio();

  Future<void> createSearchInterest(
    String origin,
    String destination,
    String departureDate,
    String userID,
  ) async {
    const createSearchInterestURL =
        '${constants.apiRoot}/profile/shuttle-interest/create';
    var params = {
      'origin': origin,
      'destination': destination,
      'departureDate': departureDate,
      'userID': userID,
    };
    await dio
        .post(createSearchInterestURL, data: params)
        .then((response) {
          log('createSearchInterest data: ${response.data}');
        })
        .catchError((error) {
          if (error is DioException) {
            log('createSearchInterest DioException: ${error.response}');
          } else {
            log('createSearchInterest error: $error');
          }
        });
  }

  Future<List<Shuttle>?> getShuttleCompanies() async {
    const shuttleCompaniesURL = '${constants.apiRoot}/shuttles';
    List<Shuttle>? shuttles;
    try {
      await dio
          .get(shuttleCompaniesURL)
          .then((response) {
            final List<dynamic> json = response.data;
            shuttles = json.map((item) => Shuttle.fromMap(item)).toList();
          })
          .catchError((e) {
            if (e is DioException) {
              log('getShuttleCompanies DioException: $e');
            } else {
              log('getShuttleCompanies error: $e');
            }
          });
    } catch (e) {
      log(e.toString());
    }
    return shuttles;
  }

  Future<List<ShuttleRoute>?> getShuttleRoutes(
    String origin,
    String destination,
  ) async {
    var params = {'origin': origin, 'destination': destination};
    log(params.toString());
    const shuttleRoutesURL = '${constants.apiRoot}/shuttle/routes';
    List<ShuttleRoute>? shuttleRoutes;
    try {
      await dio
          .get(shuttleRoutesURL, data: params)
          .then((response) {
            final List<dynamic> json = response.data;
            shuttleRoutes =
                json.map((item) => ShuttleRoute.fromMap(item)).toList();
          })
          .catchError((e) {
            if (e is DioException) {
              log('getShuttleRoutes DioException: $e');
            } else {
              log('getShuttleRoutes error: $e');
            }
          });
    } catch (e) {
      log(e.toString());
    }
    return shuttleRoutes;
  }

  Future<List<ShuttleBooking>?> getBookingsFromSupabase(String userId) async {
    var params = {'userID': userId};
    const bookingsURL = '${constants.apiRoot}/shuttle/bookings';
    List<ShuttleBooking> bookings = [];

    await dio
        .get(bookingsURL, data: params)
        .then((response) {
          final List<dynamic> json = response.data;
          bookings = json.map((item) => ShuttleBooking.fromMap(item)).toList();
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

  Future<void> bookShuttle(ShuttleBooking shuttleBooking) async {
    const shuttleBookingURL = '${constants.apiRoot}/shuttle/booking/create';
    const paynowURL = '${constants.apiRoot}/pay';
    var params = {
      'companyID': shuttleBooking.companyID,
      'userID': shuttleBooking.userID,
      'routeID': shuttleBooking.routeID,
      'firstName': shuttleBooking.firstName,
      'lastName': shuttleBooking.lastName,
      'phoneNumber': shuttleBooking.phoneNumber,
      'email': shuttleBooking.email,
      'origin': shuttleBooking.origin,
      'destination': shuttleBooking.destination,
      'departureDate': shuttleBooking.departureDate,
      'amountPaid': shuttleBooking.amountPaid,
    };
    var paynowParams = {'busFare': shuttleBooking.amountPaid};

    log('bookShuttle params.userID: ${shuttleBooking.userID}');

    // Post transactions into Paynow
    await dio
        .post(paynowURL, data: paynowParams)
        .then((response) {
          log('Paynow response: ${response.data}');
          return response;
        })
        .catchError((e) {
          if (e is DioException) {
            log('bookShuttle DioException: ${e.response}');
            return e.response!;
          } else {
            log('bookShuttle error: $e');
            return e;
          }
        });

    // Post transaction into Supabase
    await dio
        .post(shuttleBookingURL, data: params)
        .then((response) {
          log('bookShuttle response: $response');
          return response;
        })
        .catchError((e) {
          if (e is DioException) {
            log('bookShuttle DioException: ${e.response}');
            return e.response!;
          } else {
            log('bookShuttle error: $e');
            return e;
          }
        });
  }
}
