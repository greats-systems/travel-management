import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/pages/home.dart';
import 'package:travel_management_app_2/pages/login.dart';
import 'package:travel_management_app_2/pages/register.dart';
import 'package:travel_management_app_2/screens/flights/views/available_flights.dart';
import 'auth/auth_gate.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: dotenv.get('URL'),
    anonKey: dotenv.get('ROLE_KEY'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/auth-gate',
      routes: {
        '/auth-gate': (BuildContext context) => AuthGate(),
        '/home': (BuildContext context) => HomePage(),
        '/available-flights': (BuildContext context) => AvailableFlights(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
      },
    );
  }
}
