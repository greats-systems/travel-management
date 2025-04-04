import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/flights/views/available_flights.dart';

enum TripType { oneWay, roundTrip }

class SearchFlights extends StatefulWidget {
  const SearchFlights({super.key});

  @override
  State<SearchFlights> createState() => _SearchFlightsState();
}

class _SearchFlightsState extends State<SearchFlights> {
  final _destinationController = TextEditingController();
  final _departureDateController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _adultsController = TextEditingController();
  TripType _tripType = TripType.oneWay;
  final DateTime _selectedDate = DateTime.now();

  void search() {
    // log(
    //   'search\n${constants.returnAirportCode(_destinationController.text)}\n${_departureDateController.text}\n${_returnDateController.text}\n${_adultsController.text}',
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            _tripType == TripType.oneWay
                ? (context) => AvailableFlights(
                  origin: 'HRE',
                  destination: constants.returnAirportCode(
                    _destinationController.text,
                  ),
                  departureDate: _departureDateController.text,
                  returnDate: null,
                  adults: int.parse(_adultsController.text),
                )
                : (context) => AvailableFlights(
                  origin: 'HRE',
                  destination: constants.returnAirportCode(
                    _destinationController.text,
                  ),
                  departureDate: _departureDateController.text,
                  returnDate: _returnDateController.text,
                  adults: int.parse(_adultsController.text),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Search Flights')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 2,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: ListView(
            children: [
              MyTextField(
                textInputType: TextInputType.text,
                controller: _destinationController,
                hintText: 'Destination',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyDatePicker(
                controller: _departureDateController,
                helpText: 'Departure date',
                fieldLabelText: 'Select departure date',
                labelText: 'Departure date',
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              _tripType == TripType.roundTrip
                  ? Column(
                    children: [
                      MyDatePicker(
                        helpText: 'Return date',
                        fieldLabelText: 'Select return date',
                        labelText: 'Return date',
                        controller: _returnDateController,
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                  : const SizedBox(height: 20),
              MyTextField(
                textInputType: TextInputType.number,
                controller: _adultsController,
                hintText: 'Number of adults',
                obscureText: false,
              ),
              const SizedBox(height: 20),
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
