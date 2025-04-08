import 'package:dio/dio.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'dart:developer';

class SearchInterestController {
  Dio dio = Dio();

  Future<void> createSearchInterest(
    String origin,
    String destination,
    String departureDate,
    bool oneWay,
    String? returnDate,
    int adults,
    String? userID,
  ) async {
    const createSearchInterestURL =
        '${constants.apiRoot}/profile/searches/create';
    var params = {
      'origin': origin,
      'destination': destination,
      'departureDate': departureDate,
      'oneWay': oneWay,
      'returnDate': returnDate,
      'adults': adults,
      'userID': userID,
    };
    await dio
        .post(createSearchInterestURL, data: params)
        .then((response) {
          log('createSearchInterest data: ${response.data}');
        })
        .catchError((e) {
          if (e is DioException) {
            log('createSearchInterest DioException: ${e.message}');
          } else {
            log('createSearchInterest error: $e');
          }
        });
  }
}
