import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static const createProfileURL = '${constants.apiRoot}/profile/create';
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
    String email,
    String password,
    String firstName,
    String lastName,
    String phone,
  ) async {
    log('Email: $email\t Phone:$phone');

    try {
      var signupData = await _supabase.auth.signUp(
        email: email,
        // phone: phone,
        password: password,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone': phone,
          'role': 'tourist',
        },
      );
      log(
        'signup_data user: ${JsonEncoder.withIndent(' ').convert(signupData.user)}',
      );
      final id = signupData.user!.id;

      var params = {
        'id': id.toString(),
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'role': 'tourist',
      };
      await dio.post(createProfileURL, data: params).then((response) {
        log(
          'Profile data: ${JsonEncoder.withIndent(' ').convert(response.data)}',
        );
      });
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

  // Get user's metadata (useful when fetching an account number)
  Map<String, dynamic>? getCurrentUser() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata;
  }
}
