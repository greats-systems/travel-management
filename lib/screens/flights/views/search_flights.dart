import 'dart:developer';

import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/flights/controllers/search_interest_controller.dart';
import 'package:travel_management_app_2/screens/flights/views/available_flights/available_flights.dart';

enum TripType { oneWay, roundTrip }

class SearchFlights extends StatefulWidget {
  const SearchFlights({super.key});

  @override
  State<SearchFlights> createState() => _SearchFlightsState();
}

class _SearchFlightsState extends State<SearchFlights> {
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _departureDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  double _currentSliderValue = 1;
  final AuthService authService = AuthService();
  TripType _tripType = TripType.oneWay;
  String? id;
  final SearchInterestController searchInterestController =
      SearchInterestController();

  void getUserID() async {
    setState(() {
      id = authService.getCurrentUserID();
    });
    log('User ID from search_flights: $id');
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

  void search() {
    try {
      _tripType == TripType.oneWay
          ? searchInterestController.createSearchInterest(
            _originController.text,
            _destinationController.text,
            _departureDateController.text,
            true,
            null,
            int.parse(_currentSliderValue.round().toString()),
            id,
          )
          : searchInterestController.createSearchInterest(
            _originController.text,
            _destinationController.text,
            _departureDateController.text,
            false,
            _returnDateController.text,
            int.parse(_currentSliderValue.round().toString()),
            id,
          );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              _tripType == TripType.oneWay
                  ? (context) => AvailableFlights(
                    origin: constants.returnAirportCode(_originController.text),
                    destination: constants.returnAirportCode(
                      _destinationController.text,
                    ),
                    departureDate: _departureDateController.text,
                    returnDate: null,
                    adults: int.parse(_currentSliderValue.round().toString()),
                  )
                  : (context) => AvailableFlights(
                    origin: constants.returnAirportCode(_originController.text),
                    destination: constants.returnAirportCode(
                      _destinationController.text,
                    ),
                    departureDate: _departureDateController.text,
                    returnDate: _returnDateController.text,
                    adults: int.parse(_currentSliderValue.round().toString()),
                  ),
        ),
      );
    } catch (e, s) {
      log('Error performing search: $e $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Search Flights')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 5,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: ListView(
            children: [
              Center(
                child: Text(
                  'Look for a flight',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              MySizedBox(),
              MyTextField(
                textInputType: TextInputType.text,
                controller: _originController,
                hintText: 'Origin',
                obscureText: false,
              ),
              MySizedBox(),
              MyTextField(
                textInputType: TextInputType.text,
                controller: _destinationController,
                hintText: 'Destination',
                obscureText: false,
              ),
              MySizedBox(),
              MyDatePicker(
                controller: _departureDateController,
                helpText: 'Departure date',
                fieldLabelText: 'Select departure date',
                labelText: 'Departure date',
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
              ),
              MySizedBox(),
              Row(
                children: [
                  Radio<TripType>(
                    value: TripType.oneWay,
                    groupValue: _tripType,
                    onChanged: (TripType? value) {
                      setState(() {
                        _tripType = value!;
                      });
                    },
                  ),
                  const Text('One Way'),
                  Radio<TripType>(
                    value: TripType.roundTrip,
                    groupValue: _tripType,
                    onChanged: (TripType? value) {
                      setState(() {
                        _tripType = value!;
                      });
                    },
                  ),
                  const Text('Round trip'),
                ],
              ),
              MySizedBox(),
              _tripType == TripType.roundTrip
                  ? Column(
                    children: [
                      MyDatePicker(
                        helpText: 'Return date',
                        fieldLabelText: 'Select return date',
                        labelText: 'Return date',
                        controller: _returnDateController,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      ),
                      MySizedBox(),
                    ],
                  )
                  : MySizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: const Text('Adults'),
                  ),
                  Slider(
                    value: _currentSliderValue,
                    min: 1,
                    max: 9,
                    divisions: 8,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                        log(value.round().toString());
                      });
                    },
                  ),
                ],
              ),
              MySizedBox(),
              MyButton(
                onTap: search,
                text: 'Search',
                color: Colors.blue.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
