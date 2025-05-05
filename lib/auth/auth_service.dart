import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/auth/models/mobile_user.dart';

class AuthService {
  static const createProfileURL = '${constants.apiRoot}/profile/create';
  static const createDriverProfileURL =
      '${constants.apiRoot}/profile/driver/create';
  final SupabaseClient _supabase = Supabase.instance.client;
  final dio = Dio();

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password
  Future<void> signUpWithEmailAndPassword(
    MobileUser user,
    String password,
  ) async {
    log('Email: ${user.email}\t Phone:${user.phone}');

    try {
      var signupData = await _supabase.auth.signUp(
        email: user.email,
        password: password,
        data: {
          'first_name': user.firstName,
          'last_name': user.lastName,
          'email': user.email,
          'phone': user.phone,
          'role': user.role,
        },
      );
      final id = signupData.user!.id;

      var params = {
        'id': id.toString(),
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'phone': user.phone,
        'role': user.role,
      };

      var driverParams = {
        'userID': id.toString(),
        'dob': user.dob,
        'licenseClass': user.licenseClass,
        'vehicleRegNumber': user.vehicleRegNumber,
      };
      if (user.role == 'traveller') {
        await dio
            .post(createProfileURL, data: params)
            .then((response) {
              log(
                'Profile data: ${JsonEncoder.withIndent(' ').convert(response.data.statusText)}',
              );
            })
            .catchError((e) {
              if (e is DioException) {
                log('DioException: ${e.response.toString()}');
              } else {
                log('error: ${e.response.toString()}');
              }
            });
        ;
      } else if (user.role == 'driver') {
        log(user.role!);
        await dio.post(createProfileURL, data: params);
        await dio
            .post(createDriverProfileURL, data: driverParams)
            .then((response) {
              log(
                'Profile data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
              );
            })
            .catchError((e) {
              if (e is DioException) {
                log('DioException: ${e.response.toString()}');
              } else {
                log('error: ${e.response.toString()}');
              }
            });
      } else {
        log('Unrecognized role');
      }
    } catch (e) {
      log('Error creating user: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get user's email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // Get user's ID
  String? getCurrentUserID() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

  // Get user's role
  String? getCurrentUserRole() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user!.userMetadata!['role'];
  }

  // Get user's metadata (useful when fetching an account number)
  Map<String, dynamic>? getCurrentUser() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata;
  }
}
