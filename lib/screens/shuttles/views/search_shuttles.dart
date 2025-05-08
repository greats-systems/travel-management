import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_local_autocomplete.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/views/available_shuttles/available_shuttles_landing_page.dart';

class SearchShuttles extends StatefulWidget {
  final String userId;
  final Position position;

  const SearchShuttles({
    super.key,
    required this.userId,
    required this.position,
  });

  @override
  State<SearchShuttles> createState() => _SearchShuttlesState();
}

class _SearchShuttlesState extends State<SearchShuttles> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _departureDateController =
      TextEditingController();
  final ShuttleController _shuttleController = ShuttleController();
  String? _origin;
  String? _destination;

  @override
  void dispose() {
    _departureDateController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    if (_origin == null || _origin!.isEmpty) {
      _showErrorSnackbar('Please select an origin');
      return false;
    }
    if (_destination == null || _destination!.isEmpty) {
      _showErrorSnackbar('Please select a destination');
      return false;
    }
    if (_departureDateController.text.isEmpty) {
      _showErrorSnackbar('Please select a departure date');
      return false;
    }
    return true;
  }

  void _showErrorSnackbar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _searchShuttles() async {
    if (!_validateFields()) return;

    try {
      await _shuttleController.createSearchInterest(
        origin: _origin!,
        destination: _destination!,
        departureDate: _departureDateController.text,
        userID: widget.userId,
        currentLocationLat: widget.position.latitude,
        currentLocationLong: widget.position.longitude,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => AvailableShuttlesLandingPage(
                userId: widget.userId,
                origin: _origin!,
                destination: _destination!,
                departureDate: _departureDateController.text,
              ),
        ),
      );
    } catch (e) {
      log('Error searching for shuttles: $e');
      _showErrorSnackbar('Failed to search for shuttles. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: screenWidth / 5,
            left: screenWidth / 10,
            right: screenWidth / 10,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Center(
                  child: Text(
                    'Look for a shuttle',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const MySizedBox(),
                MyLocalAutocomplete(
                  onCitySelected: (city) => setState(() => _origin = city),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please select an origin'
                              : null,
                  initialValue: _origin,
                  hintText: 'Origin',
                ),
                const MySizedBox(),
                MyLocalAutocomplete(
                  onCitySelected: (city) => setState(() => _destination = city),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please select a destination'
                              : null,
                  initialValue: _destination,
                  hintText: 'Destination',
                ),
                const MySizedBox(),
                MyDatePicker(
                  helpText: 'Departure date',
                  fieldLabelText: 'Departure date',
                  labelText: 'Departure date',
                  controller: _departureDateController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please select a date'
                              : null,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                ),
                const MySizedBox(),
                MyButton(
                  onTap: _searchShuttles,
                  text: 'Search',
                  color: Colors.blue.shade300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
