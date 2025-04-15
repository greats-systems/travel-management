import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_autocomplete.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/screens/shuttles/controllers/shuttle_controller.dart';
import 'package:travel_management_app_2/screens/shuttles/views/available_shuttles/available_shuttle_services.dart';

class SearchShuttles extends StatefulWidget {
  const SearchShuttles({super.key});

  @override
  State<SearchShuttles> createState() => _SearchShuttlesState();
}

class _SearchShuttlesState extends State<SearchShuttles> {
  final AuthService _authService = AuthService();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _departureDateController =
      TextEditingController();
  final ShuttleController _shuttleController = ShuttleController();
  String? userID;
  String? _origin;
  String? _destination;

  void getUserID() {
    setState(() {
      userID = _authService.getCurrentUserID();
    });
    log('User ID from SearchShuttles: $userID');
  }

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }

  void search() async {
    try {
      await _shuttleController.createSearchInterest(
        _originController.text,
        _destinationController.text,
        _departureDateController.text,
        userID!,
      );
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => AvailableShuttleServices(
                  origin: _originController.text,
                  destination: _destinationController.text,
                  departureDate: _departureDateController.text,
                ),
          ),
        );
      }
    } catch (e) {
      log('Error on search $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Look for a shuttle',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              MySizedBox(),
              MyAutocomplete(
                onCitySelected: (city) {
                  setState(() {
                    _origin = city;
                  });
                },
                initialValue: _origin,
                hintText: 'Origin',
              ),
              MySizedBox(),
              MyAutocomplete(
                onCitySelected: (city) {
                  setState(() {
                    _destination = city;
                  });
                },
                initialValue: _destination,
                hintText: 'Destination',
              ),
              MySizedBox(),
              MyDatePicker(
                helpText: 'Departure date',
                fieldLabelText: 'Departure date',
                labelText: 'Departure date',
                controller: _departureDateController,
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
              ),
              MySizedBox(),
              MyButton(
                onTap: search,
                text: 'Search',
                color: Colors.blue.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
