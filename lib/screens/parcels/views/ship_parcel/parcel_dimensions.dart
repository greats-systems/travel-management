import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_snack_bar.dart';
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/screens/parcels/controllers/parcel_controller.dart';

class ParcelDimensions extends StatefulWidget {
  final String userId;
  final ParcelShipment parcelShipment;
  const ParcelDimensions({
    super.key,
    required this.parcelShipment,
    required this.userId,
  });

  @override
  State<ParcelDimensions> createState() => _ParcelDimensionsState();
}

class _ParcelDimensionsState extends State<ParcelDimensions> {
  final _phoneNumberController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String _completePhoneNumber = '';

  // Constants for shipping calculation
  static const _baseCost = 5.00;
  static const _weightFactor = 0.50;
  static const _distanceFactor = 0.10;
  static const _volumeDivisor = 5000;
  static const _maxDimension = 200.0;
  double _length = 0.0;
  double _width = 0.0;
  double _height = 0.0;
  double _mass = 0.0;
  double _quantity = 1.0;
  double _shippingCost = 0.0;

  final _departureDateController = TextEditingController();

  bool _isLoading = false;

  // Services
  final ParcelController _parcelController = ParcelController();

  Future<void> _calculateShippingCost() async {
    final origin = widget.parcelShipment.origin;
    final destination = widget.parcelShipment.destination;
    if (origin == null || destination == null) return;

    try {
      // Calculate volumetric weight
      final volume = _length * _width * _height;
      final dimWeightKg = volume / _volumeDivisor;
      final chargeableWeight = max(_mass, dimWeightKg);

      // Get distance between locations
      final origins = await locationFromAddress(origin);
      final destinations = await locationFromAddress(destination);

      final geocodedOrigin = origins.first;
      final geocodedDestination = destinations.first;

      developer.log(
        'Origin: ${geocodedOrigin.latitude} ${geocodedOrigin.longitude}',
      );
      developer.log(
        'Dstination: ${geocodedDestination.latitude} ${geocodedDestination.longitude}',
      );

      final distanceKm = await _parcelController.calculateDistance(
        geocodedOrigin.latitude,
        geocodedOrigin.longitude,
        geocodedDestination.latitude,
        geocodedDestination.longitude,
      );
      developer.log('distanceKm: $distanceKm');

      // Calculate final cost
      final cost =
          (_baseCost +
              (chargeableWeight * _weightFactor) +
              (distanceKm * _distanceFactor)) *
          _quantity;

      if (mounted) {
        setState(() => _shippingCost = cost);
      }
    } catch (e) {
      developer.log('Error calculating shipping cost: $e');
    }
  }

  void _createParcelShipment() async {
    setState(() => _isLoading = true);

    widget.parcelShipment
      ..length = _length
      ..width = _width
      ..height = _height
      ..mass = _mass
      ..quantity = _quantity.toInt()
      ..departureDate = _departureDateController.text.trim()
      ..shippingCost = _shippingCost;
    developer.log(JsonEncoder.withIndent(' ').convert(widget.parcelShipment));

    try {
      await _parcelController.makeParcelEcocashPayment(
        widget.parcelShipment.shippingCost!,
        _completePhoneNumber,
      );
      await _parcelController.createParcelShipment(widget.parcelShipment);
      if (!mounted) return;
      MySnackBar.showSnackBar(
        context,
        'Your cargo request was submitted successfully!',
        Colors.green,
      );
      _phoneNumberController.clear();
      _completePhoneNumber = '';
      _length = 0.0;
      _width = 0.0;
      _height = 0.0;
      _mass = 0.0;
      _quantity = 0;
      _departureDateController.clear();
      Navigator.popAndPushNamed(context, '/landing-page');
    } on DioException catch (e) {
      if (!mounted) return;
      MySnackBar.showSnackBar(
        context,
        e.response?.toString() ?? 'Network error',
        Colors.yellow,
      );
    } catch (e) {
      if (!mounted) return;
      MySnackBar.showSnackBar(context, 'Error: ${e.toString()}', Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _departureDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final horizontalPadding = mediaQuery.size.width / 15;
    final topPadding = mediaQuery.size.width / 3;

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

              // Phone number field
              _buildPhoneNumberField(),

              // Dimensions row
              _buildDimensionsRow(),
              MySizedBox(),

              // Mass and quantity row
              _buildMassQuantityRow(),
              MySizedBox(),

              // Departure date
              _buildDateField(),
              MySizedBox(),

              // Shipping cost card
              _buildShippingCostCard(),

              // Submit button
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MyButton(
                    onTap: _createParcelShipment,
                    text: 'Confirm',
                    color: Colors.blue.shade300,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return IntlPhoneField(
      controller: _phoneNumberController,
      focusNode: focusNode,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      initialCountryCode: 'ZW',
      onChanged: (PhoneNumber phone) {
        // Store the complete international number
        _completePhoneNumber = phone.number;
        developer.log('Complete phone number: $_completePhoneNumber');
      },
      onCountryChanged: (country) {
        developer.log('Country changed to ${country.name}');
      },
    );
  }

  Widget _buildDateField() {
    return MyDatePicker(
      helpText: 'Departure date',
      fieldLabelText: 'Departure date',
      labelText: 'Departure date',
      controller: _departureDateController,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
  }

  Widget _buildDimensionsRow() {
    return Column(
      children: [
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('Length (cm)', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Width (cm)', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Height (cm)', style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 8),

        // SpinBoxes
        Row(
          children: [
            _buildDimensionSpinBox(
              value: _length,
              step: 5,
              onChanged:
                  (value) => setState(() {
                    _length = value;
                    _calculateShippingCost();
                  }),
            ),
            const SizedBox(width: 10),
            _buildDimensionSpinBox(
              value: _width,
              step: 5,
              onChanged:
                  (value) => setState(() {
                    _width = value;
                    _calculateShippingCost();
                  }),
            ),
            const SizedBox(width: 10),
            _buildDimensionSpinBox(
              value: _height,
              step: 5,
              onChanged:
                  (value) => setState(() {
                    _height = value;
                    _calculateShippingCost();
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMassQuantityRow() {
    return Column(
      children: [
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('Mass (kg)', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Units', style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 8),

        // SpinBoxes
        Row(
          children: [
            _buildDimensionSpinBox(
              value: _mass,
              step: 0.5,
              onChanged:
                  (value) => setState(() {
                    _mass = value;
                    _calculateShippingCost();
                  }),
            ),
            const SizedBox(width: 10),
            _buildDimensionSpinBox(
              value: _quantity,
              step: 1.0,
              onChanged:
                  (value) => setState(() {
                    _quantity = value;
                    _calculateShippingCost();
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShippingCostCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Subtotal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Center(child: Text('\$${_shippingCost.toStringAsFixed(2)}')),
          ],
        ),
      ),
    );
  }

  Widget _buildDimensionSpinBox({
    required double value,
    required ValueChanged<double> onChanged,
    required double step,
  }) {
    return Expanded(
      child: SpinBox(
        value: value,
        min: 0,
        max: _maxDimension,
        decimals: 1,
        step: step,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black12, width: 2.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black12, width: 4.5),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
