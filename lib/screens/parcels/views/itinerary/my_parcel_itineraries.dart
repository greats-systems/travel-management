import 'package:flutter/material.dart';

class MyParcelItineraries extends StatefulWidget {
  final String userId;
  const MyParcelItineraries({super.key, required this.userId});

  @override
  State<MyParcelItineraries> createState() => _MyParcelItinerariesState();
}

class _MyParcelItinerariesState extends State<MyParcelItineraries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('My parcel itineraries')));
  }
}
