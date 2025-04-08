import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();
  String? id;

  void logout() async {
    await authService.signOut();
  }

  void getUserID() async {
    setState(() {
      id = authService.getCurrentUserID();
      log('User ID from home: $id');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*
  void initState() {
    setState(() {
      id = getUserID()
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
        child: Column(
          children: [
            Text('Home page'),
            MySizedBox(),
            MyButton(
              onTap: logout,
              text: 'Logout',
              color: Colors.purple.shade300,
            ),
          ],
        ),
        // child: MyButton(
        //   onTap: logout,
        //   text: 'Logout',
        //   color: Colors.blue.shade300,
        // ),
      ),
    );
  }
}
