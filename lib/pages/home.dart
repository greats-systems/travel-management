import 'package:flutter/material.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();

  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: MyButton(
          onTap: logout,
          text: 'Logout',
          color: Colors.blue.shade300,
        ),
      ),
    );
  }
}
