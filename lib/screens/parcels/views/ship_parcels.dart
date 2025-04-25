import 'dart:math';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_local_autocomplete.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/screens/parcels/controllers/parcel_controller.dart';
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';

class ShipParcels extends StatefulWidget {
  const ShipParcels({super.key});

  @override
  State<ShipParcels> createState() => _ShipParcelsState();
}

class _ShipParcelsState extends State<ShipParcels> {
  // Constants for shipping calculation
  static const _baseCost = 5.00;
  static const _weightFactor = 0.50;
  static const _distanceFactor = 0.10;
  static const _volumeDivisor = 5000;
  static const _maxDimension = 200.0;

  // State variables
  bool _isLoading = false;
  String? _origin;
  String? _destination;
  double _length = 0.0;
  double _width = 0.0;
  double _height = 0.0;
  double _mass = 0.0;
  double _quantity = 1.0;
  double _shippingCost = 0.0;

  // Controllers
  final _nameController = TextEditingController();
  final _departureDateController = TextEditingController();

  // Services
  final ParcelController _parcelController = ParcelController();
  final ParcelShipment _parcelShipment = ParcelShipment();
  final AuthService _authService = AuthService();
  String? _userId;

  @override
  void initState() {
    super.initState();
    _userId = _authService.getCurrentUserID();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _departureDateController.dispose();
    super.dispose();
  }

  Future<void> _calculateShippingCost() async {
    if (_origin == null || _destination == null) return;

    try {
      // Calculate volumetric weight
      final volume = _length * _width * _height;
      final dimWeightKg = volume / _volumeDivisor;
      final chargeableWeight = max(_mass, dimWeightKg);

      // Get distance between locations
      final origins = await locationFromAddress(_origin!);
      final destinations = await locationFromAddress(_destination!);

      final origin = origins.first;
      final destination = destinations.first;

      developer.log('Origin: ${origin.latitude} ${origin.longitude}');
      developer.log(
        'Dstination: ${destination.latitude} ${destination.longitude}',
      );

      final distanceKm = await _parcelController.calculateDistance(
        origin.latitude,
        origin.longitude,
        destination.latitude,
        destination.longitude,
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
      debugPrint('Error calculating shipping cost: $e');
    }
  }

  void _createParcelShipment() async {
    if (_userId == null) return;

    setState(() => _isLoading = true);

    _parcelShipment
      ..userId = _userId!
      ..name = _nameController.text.trim()
      ..length = _length
      ..width = _width
      ..height = _height
      ..mass = _mass
      ..quantity = _quantity.toInt()
      ..origin = _origin
      ..destination = _destination
      ..departureDate = _departureDateController.text;

    try {
      await _parcelController.createParcelShipment(_parcelShipment);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Shipment request successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response?.toString() ?? 'Network error'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
                  'Send a parcel',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              MySizedBox(),
              MyTextField(
                controller: _nameController,
                hintText: 'Name',
                obscureText: false,
                textInputType: TextInputType.text,
              ),
              MySizedBox(),
              MyLocalAutocomplete(
                onCitySelected:
                    (city) => setState(() {
                      _origin = city;
                      _calculateShippingCost();
                    }),
                initialValue: _origin,
                hintText: 'Origin',
              ),
              MySizedBox(),
              MyLocalAutocomplete(
                onCitySelected:
                    (city) => setState(() {
                      _destination = city;
                      _calculateShippingCost();
                    }),
                initialValue: _destination,
                hintText: 'Destination',
              ),
              MySizedBox(),

              // Dimensions row
              _buildDimensionsRow(),
              MySizedBox(),

              // Mass and quantity row
              _buildMassQuantityRow(),
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
              step: 0.5,
              onChanged:
                  (value) => setState(() {
                    _length = value;
                    _calculateShippingCost();
                  }),
            ),
            const SizedBox(width: 10),
            _buildDimensionSpinBox(
              value: _width,
              step: 0.5,
              onChanged:
                  (value) => setState(() {
                    _width = value;
                    _calculateShippingCost();
                  }),
            ),
            const SizedBox(width: 10),
            _buildDimensionSpinBox(
              value: _height,
              step: 0.5,
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
            Text('Quantity', style: TextStyle(fontWeight: FontWeight.w500)),
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
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
