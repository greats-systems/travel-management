/*

AUTH GATE - This will continuously listen for auth state changes

---------------------------------------------------------------------------------------

if authenticated => NavigationPage
if not authenticated => LoginPage

 */

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/pages/home.dart';
import 'package:travel_management_app_2/pages/login.dart';
import 'package:travel_management_app_2/screens/flights/views/available_flights.dart';
import 'package:travel_management_app_2/screens/flights/views/search_flights.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    return BlocBuilder(builder: (context, state) {
      if (state is AuthInitialState) {
        return Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      } else if (state is AuthenticatedState) {
        return APINavigationPage();
      } else {
        return Scaffold(
          body: Center(
            child: Text('Unknown state'),
          ),
        );
      }
    });
    */

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
          return SearchFlights();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
