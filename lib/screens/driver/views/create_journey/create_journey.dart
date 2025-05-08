import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_local_autocomplete.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_snack_bar.dart';
import 'package:travel_management_app_2/screens/driver/controllers/driver_controller.dart';
import 'package:travel_management_app_2/screens/driver/models/journey.dart';
import 'package:travel_management_app_2/services/journey_service.dart';

class CreateJourney extends StatefulWidget {
  final String userId;
  final Position position;
  const CreateJourney({
    super.key,
    required this.userId,
    required this.position,
  });

  @override
  State<CreateJourney> createState() => _CreateJourneyState();
}

class _CreateJourneyState extends State<CreateJourney> {
  // Controllers and state variables
  final DriverController _driverController = DriverController();
  final TextEditingController _departureDateController =
      TextEditingController();
  String? _origin;
  String? _destination;

  // Constants
  static const _titleText = 'Go on a trip';
  static const _titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const _buttonColor = Colors.blue;

  @override
  void dispose() {
    _departureDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = EdgeInsets.only(
      top: screenWidth / 8,
      left: screenWidth / 10,
      right: screenWidth / 10,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: ListView(
            children: [
              _buildTitle(),
              MySizedBox(),
              _buildOriginField(),
              MySizedBox(),
              _buildDestinationField(),
              MySizedBox(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(child: Text(_titleText, style: _titleStyle));
  }

  Widget _buildOriginField() {
    return MyLocalAutocomplete(
      onCitySelected: (city) => setState(() => _origin = city),
      initialValue: _origin,
      hintText: 'Origin',
    );
  }

  Widget _buildDestinationField() {
    return MyLocalAutocomplete(
      onCitySelected: (city) => setState(() => _destination = city),
      initialValue: _destination,
      hintText: 'Destination',
    );
  }

  Widget _buildSubmitButton() {
    return MyButton(
      onTap: confirm,
      text: 'Confirm',
      color: _buttonColor.shade300,
    );
  }

  Future<void> confirm() async {
    if (_origin == null || _destination == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
    }

    log('Creating journey from $_origin to $_destination');

    try {
      Journey journey = Journey(
        userID: widget.userId,
        origin: _origin!,
        destination: _destination!,
        currentLocationLat: widget.position.latitude,
        currentLocationLong: widget.position.longitude,
      );

      final response = await _driverController.createJourney(journey);
      log('Journey created successfully: ${response.data['success']}');
      _origin = '';
      _destination = '';
      if (mounted) {
        if (response.data['success'] != true) {
          MySnackBar.showSnackBar(
            context,
            response.data['message'].toString(),
            Colors.red,
          );
        } else {
          MySnackBar.showSnackBar(
            context,
            'Journey added successfully!',
            Colors.green,
          );
          // After successfully creating a journey:
          final journeyService = Provider.of<JourneyService>(
            context,
            listen: false,
          );
          await journeyService.fetchUserJourney(widget.userId);
        }
      }
    } catch (e) {
      if (mounted) {
        log('Error creating journey: $e');
        MySnackBar.showSnackBar(
          context,
          'Failed to create journey: ${e.toString()}',
          Colors.red,
        );
      }
    }
  }
}
