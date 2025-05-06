import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:travel_management_app_2/screens/driver/models/journey.dart';
import 'package:travel_management_app_2/screens/driver/models/osrm_route.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:dio/dio.dart';
import 'dart:developer';

class DriverController {
  Dio dio = Dio();

  Future<OSRMRoute?> getRoute(LatLng origin, LatLng destination) async {
    const journeyURL = '${constants.apiRoot}/journey/route';
    final params = {
      'originLat': origin.latitude.toString(),
      'originLong': origin.longitude.toString(),
      'destinationLat': destination.latitude.toString(),
      'destinationLong': destination.longitude.toString(),
    };

    log('Requesting route with params: $params');

    try {
      final response = await dio.get(
        journeyURL,
        queryParameters: params,
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
      );

      // Validate basic response structure
      if (response.data == null) {
        log('Null response received');
        return null;
      }

      if (response.data is! Map<String, dynamic>) {
        log('Invalid route response format: ${response.data}');
        return null;
      }

      final responseData = response.data as Map<String, dynamic>;

      // Check for explicit error case
      if (responseData.containsKey('error')) {
        log('API returned error: ${responseData['error']}');
        return null;
      }

      // Check for successful response
      if (responseData['success'] == true && responseData['data'] != null) {
        try {
          return OSRMRoute.fromMap(responseData['data']);
        } catch (e, stackTrace) {
          log('Failed to parse route data', error: e, stackTrace: stackTrace);
          return null;
        }
      } else {
        log('Unexpected response format: ${responseData['success'] == true}');
      }
      return null;
    } on DioException catch (e) {
      log('''
Route request failed:
- Error: ${e.message}
- URL: ${e.requestOptions.uri}
- Status: ${e.response?.statusCode}
- Response: ${e.response?.data}
''');
      return null;
    } catch (e, stackTrace) {
      log('Unexpected error in getRoute', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<Response<dynamic>> createJourney(Journey journey) async {
    const createJourneyURL = '${constants.apiRoot}/journey/create';
    final checkActiveJourneyURL =
        '${constants.apiRoot}/journey/active/${journey.userID}';

    try {
      // 1. Check for active journey
      final activeJourneyResponse = await dio.get(checkActiveJourneyURL);
      log('Active journey check: ${jsonEncode(activeJourneyResponse.data)}');

      // 2. Parse response safely
      final responseData = activeJourneyResponse.data as Map<String, dynamic>;

      if (responseData['hasActiveJourney'] == true) {
        final activeJourney =
            responseData['activeJourney'] as Map<String, dynamic>?;
        return Response(
          requestOptions: RequestOptions(path: createJourneyURL),
          statusCode: 400,
          statusMessage:
              'Active journey exists${activeJourney != null ? ' (ID: ${activeJourney['user_id']})' : ''}',
          data: {
            'success': false,
            'error': 'active_journey_exists',
            'message': 'You already have an active journey',
            'existingJourney': activeJourney,
          },
        );
      }

      // 3. Create new journey
      final params = {
        'userID': journey.userID,
        'currentLocationLat': journey.currentLocationLat,
        'currentLocationLong': journey.currentLocationLong,
        'origin': journey.origin,
        'destination': journey.destination,
      };

      final response = await dio.post(createJourneyURL, data: params);
      return response;
    } on DioException catch (e) {
      log('DioError: ${e.response?.data ?? e.message}');
      return Response(
        requestOptions: RequestOptions(path: createJourneyURL),
        statusCode: e.response?.statusCode ?? 500,
        statusMessage: e.message,
        data: {
          'success': false,
          'error': 'network_error',
          'message':
              e.response?.data is Map
                  ? e.response!.data['error'] ?? 'Failed to create journey'
                  : 'Failed to create journey',
        },
      );
    } catch (e) {
      log('Error: $e');
      return Response(
        requestOptions: RequestOptions(path: createJourneyURL),
        statusCode: 500,
        statusMessage: 'Internal server error',
        data: {
          'success': false,
          'error': 'server_error',
          'message': 'Failed to create journey',
        },
      );
    }
  }

  Future<Journey?> getJourneyFromSupabase(String userID) async {
    try {
      final response = await dio.get(
        '${constants.apiRoot}/journeys/$userID',
        queryParameters: {'user_id': userID},
      );
      log(
        'getJourneyFromSupabase data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
      );

      // Validate response structure
      if (response.data == null) {
        return null;
      } else if (response.data is Map<String, dynamic> &&
          response.data['data'].length > 0) {
        return Journey.fromMap(response.data);
      } else {
        log('Unexpected response format: ${response.data.runtimeType}');
        return null;
      }
    } on DioException catch (e) {
      log('Error fetching journey: ${e.response?.data ?? e.message}');
      return null;
    }
  }
}
