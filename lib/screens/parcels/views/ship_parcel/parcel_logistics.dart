import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/components/my_local_autocomplete.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';
import 'package:travel_management_app_2/screens/parcels/views/ship_parcel/parcel_dimensions.dart';

class ParcelLogistics extends StatefulWidget {
  final String userId;
  const ParcelLogistics({super.key, required this.userId});

  @override
  State<ParcelLogistics> createState() => _ParcelLogisticsState();
}

class _ParcelLogisticsState extends State<ParcelLogistics> {
  // Controllers
  final _nameController = TextEditingController();
  String? _origin;
  String? _destination;
  String? _courier;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final horizontalPadding = mediaQuery.size.width / 10;
    final topPadding = mediaQuery.size.width / 5;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: topPadding,
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  'Send cargo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              MySizedBox(),

              // Parcel name
              _buildParcelNameField(),
              MySizedBox(),

              // Origin
              _buildOriginTextField(),
              MySizedBox(),

              // Destination
              _buildDestinationTextField(),
              MySizedBox(),

              // Courier selection
              _buildCourierDropdown(),
              MySizedBox(),

              // Next page
              _navigateToNextPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParcelNameField() {
    return MyTextField(
      controller: _nameController,
      hintText: 'Parcel name',
      obscureText: false,
      textInputType: TextInputType.text,
    );
  }

  Widget _buildOriginTextField() {
    return MyLocalAutocomplete(
      onCitySelected:
          (city) => setState(() {
            _origin = city;
            // _calculateShippingCost();
          }),
      initialValue: _origin,
      hintText: 'Origin',
      validator:
          (value) =>
              value == null || value.isEmpty ? 'Please select an origin' : null,
    );
  }

  Widget _buildDestinationTextField() {
    return MyLocalAutocomplete(
      onCitySelected:
          (city) => setState(() {
            _destination = city;
          }),
      initialValue: _destination,
      hintText: 'Destination',
      validator:
          (value) =>
              value == null || value.isEmpty
                  ? 'Please select a destination'
                  : null,
    );
  }

  void setCourierDropdownValue(value) {
    setState(() {
      _courier = value;
    });
    developer.log(_courier!);
  }

  Widget _buildCourierDropdown() {
    final List<String> courierList = ['DHL', 'FedEx', 'UPS', 'InDrive'];
    final Map<String, String> couriers = {
      'DHL': constants.returnCourierLogo('DHL')!,
      'FedEx': constants.returnCourierLogo('FedEx')!,
      'UPS': constants.returnCourierLogo('UPS')!,
      'InDrive': constants.returnCourierLogo('InDrive')!,
    };

    return DropdownButton<String>(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      isExpanded: true,
      hint: Text('Courier'),
      items:
          courierList.map((name) {
            return DropdownMenuItem(
              value: name,
              child: Row(
                children: [
                  Image.asset(couriers[name]!, width: 40, height: 40),
                  SizedBox(width: 10),
                  Text(name),
                ],
              ),
            );
          }).toList(),
      value: _courier,
      onChanged: (newValue) => setCourierDropdownValue(newValue),
    );
  }

  Widget _navigateToNextPage() {
    ParcelShipment parcelShipment = ParcelShipment();
    parcelShipment
      ..userId = widget.userId
      ..name = _nameController.text
      ..origin = _origin
      ..destination = _destination
      ..courierName = _courier;
    log(JsonEncoder.withIndent(' ').convert(parcelShipment));
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: false,
              builder:
                  (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Parcel Dimensions'),
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    body: ParcelDimensions(
                      parcelShipment: parcelShipment,
                      userId: widget.userId,
                    ),
                  ),
            ),
          );
        },
        child: const Text('Next', style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}
