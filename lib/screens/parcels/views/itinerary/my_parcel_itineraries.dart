import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/parcels/controllers/parcel_controller.dart';
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';
import 'package:travel_management_app_2/screens/parcels/widgets/parcels_list_tile.dart';

class MyParcelItineraries extends StatefulWidget {
  final String userId;
  const MyParcelItineraries({super.key, required this.userId});

  @override
  State<MyParcelItineraries> createState() => _MyParcelItinerariesState();
}

class _MyParcelItinerariesState extends State<MyParcelItineraries> {
  List<ParcelShipment>? _parcelShipments = [];
  bool _isLoading = false;
  final ParcelController _parcelController = ParcelController();

  Future<void> _fetchData() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }
    try {
      final shipments = await _parcelController.fetchParcelShipments(
        widget.userId,
      );
      if (mounted) {
        setState(() {
          _parcelShipments = shipments;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching shipments: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _parcelShipments = null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _parcelShipments == null || _parcelShipments!.isEmpty
              ? const Center(child: Text('No cargo shipments yet'))
              : ParcelsListTile(parcels: _parcelShipments!),
    );

    // return Center(child: Text('data'));
  }
}
