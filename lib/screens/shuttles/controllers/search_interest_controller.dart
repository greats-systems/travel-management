import 'package:dio/dio.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'dart:developer';

class SearchInterestController {
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
          }
        });
  }
}
