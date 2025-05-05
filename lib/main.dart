import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/screens/home/home.dart';
import 'package:travel_management_app_2/screens/landing_page.dart';
import 'package:travel_management_app_2/screens/authentication/login.dart';
import 'package:travel_management_app_2/screens/authentication/register.dart';
import 'package:travel_management_app_2/services/journey_service.dart';
import 'auth/auth_gate.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: dotenv.get('LOCAL_SUPABASE_URL'),
    anonKey: dotenv.get('LOCAL_SUPABASE_SERVICE_ROLE_KEY'),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => JourneyService(),
      child: MyApp(),
    ),
  );
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
        '/landing-page': (BuildContext context) => LandingPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
      },
    );
  }
}
