import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_management_app_2/components/my_autocomplete.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_snack_bar.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/flights/controllers/flight_controller.dart';
import 'package:travel_management_app_2/screens/flights/views/available_flights/available_flights.dart';

enum TripType { oneWay, roundTrip }

class SearchFlights extends StatefulWidget {
  final String userId;
  final Position position;

  const SearchFlights({
    super.key,
    required this.userId,
    required this.position,
  });

  @override
  State<SearchFlights> createState() => _SearchFlightsState();
}

class _SearchFlightsState extends State<SearchFlights> {
  final _departureDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _flightController = FlightController();

  double _currentSliderValue = 1;
  TripType _tripType = TripType.oneWay;
  String? _origin;
  String? _destination;

  @override
  void initState() {
    super.initState();
    log('User ID: ${widget.userId}');
  }

  @override
  void dispose() {
    _departureDateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    // Check if origin and destination are selected
    if (_origin == null || _destination == null) {
      MySnackBar.showSnackBar(
        context,
        'Please select both origin and destination',
        Colors.orange,
      );
      return false;
    }

    // Check if origin and destination are different
    if (_origin == _destination) {
      MySnackBar.showSnackBar(
        context,
        'Origin and destination cannot be the same',
        Colors.orange,
      );
      return false;
    }

    // Check if departure date is selected
    if (_departureDateController.text.isEmpty) {
      MySnackBar.showSnackBar(
        context,
        'Please select departure date',
        Colors.orange,
      );
      return false;
    }

    // For round trips, validate return date
    if (_tripType == TripType.roundTrip) {
      if (_returnDateController.text.isEmpty) {
        MySnackBar.showSnackBar(
          context,
          'Please select return date',
          Colors.orange,
        );
        return false;
      }

      // Parse dates for comparison
      final departureDate = DateTime.parse(_departureDateController.text);
      final returnDate = DateTime.parse(_returnDateController.text);

      if (returnDate.isBefore(departureDate)) {
        MySnackBar.showSnackBar(
          context,
          'Return date cannot be before departure date',
          Colors.orange,
        );
        return false;
      }

      if (returnDate.isAtSameMomentAs(departureDate)) {
        MySnackBar.showSnackBar(
          context,
          'Departure and return dates cannot be the same',
          Colors.orange,
        );
        return false;
      }
    }

    return true;
  }

  Future<void> _searchFlights() async {
    if (!_validateInputs()) return;

    try {
      await _flightController.createSearchInterest(
        origin: _origin!,
        destination: _destination!,
        departureDate: _departureDateController.text,
        oneWay: _tripType == TripType.oneWay,
        returnDate:
            _tripType == TripType.oneWay ? null : _returnDateController.text,
        adults: _currentSliderValue.round(),
        userID: widget.userId,
        currentLocationLat: widget.position.latitude,
        currentLocationLong: widget.position.longitude,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => AvailableFlights(
                userId: widget.userId,
                origin: constants.returnAirportCode(_origin!),
                destination: constants.returnAirportCode(_destination!),
                departureDate: _departureDateController.text,
                returnDate:
                    _tripType == TripType.oneWay
                        ? null
                        : _returnDateController.text,
                adults: _currentSliderValue.round(),
              ),
        ),
      );
    } catch (e, s) {
      log('Error performing search: $e', stackTrace: s);
      if (!mounted) return;

      MySnackBar.showSnackBar(
        context,
        'Failed to search flights. Please try again.',
        Colors.red,
      );
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
          child: ListView(
            children: [
              const Center(
                child: Text(
                  'Look for a flight',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const MySizedBox(),
              _buildOriginField(),
              const MySizedBox(),
              _buildDestinationField(),
              const MySizedBox(),
              _buildDepartureDateField(),
              const MySizedBox(),
              _buildTripTypeSelector(),
              const MySizedBox(),
              if (_tripType == TripType.roundTrip) ...[
                _buildReturnDateField(),
                const MySizedBox(),
              ],
              _buildPassengerSlider(),
              const MySizedBox(),
              MyButton(
                onTap: _searchFlights,
                text: 'Search',
                color: Colors.blue.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOriginField() => MyAutocomplete(
    onCitySelected: (city) {
      setState(() => _origin = city);
      log(
        'Origin selected: $_origin (${constants.returnAirportCode(_origin!)})',
      );
    },
    initialValue: _origin,
    hintText: 'Origin',
  );

  Widget _buildDestinationField() => MyAutocomplete(
    onCitySelected: (city) {
      setState(() => _destination = city);
      log(
        'Destination selected: $_destination (${constants.returnAirportCode(_destination!)})',
      );
    },
    initialValue: _destination,
    hintText: 'Destination',
  );

  Widget _buildDepartureDateField() => MyDatePicker(
    controller: _departureDateController,
    helpText: 'Departure date',
    fieldLabelText: 'Select departure date',
    labelText: 'Departure date',
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
  );

  Widget _buildReturnDateField() => MyDatePicker(
    controller: _returnDateController,
    helpText: 'Return date',
    fieldLabelText: 'Select return date',
    labelText: 'Return date',
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
  );

  Widget _buildTripTypeSelector() => Row(
    children: [
      Radio<TripType>(
        value: TripType.oneWay,
        groupValue: _tripType,
        onChanged: (value) => setState(() => _tripType = value!),
      ),
      const Text('One Way'),
      Radio<TripType>(
        value: TripType.roundTrip,
        groupValue: _tripType,
        onChanged: (value) => setState(() => _tripType = value!),
      ),
      const Text('Round trip'),
    ],
  );

  Widget _buildPassengerSlider() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: Text('Number of passengers'),
      ),
      Slider(
        value: _currentSliderValue,
        min: 1,
        max: 9,
        divisions: 8,
        label: _currentSliderValue.round().toString(),
        onChanged:
            (value) => setState(() {
              _currentSliderValue = value;
              log('Passenger count changed: ${value.round()}');
            }),
      ),
    ],
  );
}
