import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

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
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
    String first_name,
    String last_name,
    String phone,
  ) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'first_name': first_name,
        'last_name': last_name,
        'phone': phone,
        'email': email,
      },
    );
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

  // Get user's metadata (useful when fetching an account number)
  Map<String, dynamic>? getCurrentUser() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata;
  }
}
