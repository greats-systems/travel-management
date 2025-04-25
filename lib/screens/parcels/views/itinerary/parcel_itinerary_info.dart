import 'package:flutter/material.dart';

class ParcelItineraryInfo extends StatefulWidget {
  final String userId;
  const ParcelItineraryInfo({super.key, required this.userId});

  @override
  State<ParcelItineraryInfo> createState() => _ParcelItineraryInfoState();
}

class _ParcelItineraryInfoState extends State<ParcelItineraryInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Parcel itinerary info')));
  }
}
