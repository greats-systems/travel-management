import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle.dart';
import 'package:travel_management_app_2/screens/shuttles/widgets/available_shuttle_services_list_tile.dart';

class AvailableShuttleServices extends StatefulWidget {
  const AvailableShuttleServices({super.key});

  @override
  State<AvailableShuttleServices> createState() =>
      _AvailableShuttleServicesState();
}

class _AvailableShuttleServicesState extends State<AvailableShuttleServices> {
  bool _isloading = true;
  List<Shuttle>? _shuttles;
  final ShuttleController shuttleController = ShuttleController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (mounted) {
      setState(() {
        _isloading = true;
      });
      await shuttleController.getShuttleCompanies().then((data) {
        // log('Shuttles: ${JsonEncoder.withIndent(' ').convert(_shuttles)}');
        setState(() {
          _shuttles = data;
          _isloading = false;
        });
        log('Shuttles: ${JsonEncoder.withIndent(' ').convert(_shuttles)}');
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBody() {
    if (_isloading) {
      return Center(child: CircularProgressIndicator());
    }
    if (_shuttles!.isEmpty || _shuttles == null) {
      return Center(child: Text('No shuttles available'));
    }
    return SafeArea(
      child: AvailableShuttleServicesListTile(shuttles: _shuttles),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
