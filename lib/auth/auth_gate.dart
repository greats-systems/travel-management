/*

AUTH GATE - This will continuously listen for auth state changes

---------------------------------------------------------------------------------------

if authenticated => NavigationPage
if not authenticated => LoginPage

 */

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/screens/landing_page.dart';
import 'package:travel_management_app_2/screens/authentication/login/login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // listen to auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,

      // Build appropriate page for the state
      builder: (context, snapshot) {
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: const CircularProgressIndicator()),
          );
        }
        // check for valid session
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return LandingPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
