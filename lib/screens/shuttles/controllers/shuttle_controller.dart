import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_route.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class ShuttleController {
  Dio dio = Dio();

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
              log('getShuttleCompaniesDioException: $e');
            } else {
              log('getShuttleCompanies error: $e');
            }
          });
    } catch (e) {
      log(e.toString());
    }
    return shuttles;
  }

  Future<List<ShuttleRoute>?> getShuttleRoutes(String companyID) async {
    var params = {'companyID': companyID};
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
}
