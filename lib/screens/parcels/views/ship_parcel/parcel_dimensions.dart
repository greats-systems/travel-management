import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_snack_bar.dart';
import 'package:travel_management_app_2/screens/parcels/controllers/parcel_controller.dart';
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class ParcelDimensions extends StatefulWidget {
  final ParcelShipment parcelShipment;
  final Location geocodedOrigin;
  final Location geocodedDestination;

  const ParcelDimensions({
    super.key,
    required this.parcelShipment,
    required this.geocodedOrigin,
    required this.geocodedDestination,
  });

  @override
  State<ParcelDimensions> createState() => _ParcelDimensionsState();
}

class _ParcelDimensionsState extends State<ParcelDimensions> {
  // Controllers
  final _phoneNumberController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final _departureDateController = TextEditingController();

  // Form state
  double _length = 0.0;
  double _width = 0.0;
  double _height = 0.0;
  double _mass = 0.0;
  double _quantity = 1;
  double _shippingCost = 0.0;
  String _completePhoneNumber = '';
  bool _isLoading = false;

  // Constants
  static const _maxDimension = 200.0;
  final _parcelController = ParcelController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneFocusNode.dispose();
    _departureDateController.dispose();
    super.dispose();
  }

  Future<void> _createParcelShipment() async {
    setState(() => _isLoading = true);

    // Update shipment details
    widget.parcelShipment
      ..length = _length
      ..width = _width
      ..height = _height
      ..mass = _mass
      ..quantity = _quantity.toInt()
      ..departureDate = _departureDateController.text.trim()
      ..shippingCost = _shippingCost;

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

      // Reset form
      _resetForm();
      Navigator.pop(context);
    } on DioException catch (e) {
      if (!mounted) return;
      MySnackBar.showSnackBar(
        context,
        e.response?.toString() ?? 'Network error',
        Colors.orange,
      );
    } catch (e) {
      if (!mounted) return;
      MySnackBar.showSnackBar(context, 'Error: ${e.toString()}', Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _resetForm() {
    _phoneNumberController.clear();
    _departureDateController.clear();
    _completePhoneNumber = '';
    _length = 0.0;
    _width = 0.0;
    _height = 0.0;
    _mass = 0.0;
    _quantity = 1.0;
    _shippingCost = 0.0;
  }

  Future<void> _updateShippingCost() async {
    final cost = await _parcelController.calculateShippingCost(
      origin: widget.geocodedOrigin,
      destination: widget.geocodedDestination,
      shipment: widget.parcelShipment,
      quantity: _quantity,
    );
    if (mounted) setState(() => _shippingCost = cost);
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
              const MySizedBox(),

              // Phone number field
              _buildPhoneNumberField(),

              // Dimensions row
              _buildDimensionsRow(),
              const MySizedBox(),

              // Mass and quantity row
              _buildMassQuantityRow(),
              const MySizedBox(),

              // Departure date
              _buildDateField(),
              const MySizedBox(),

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
      focusNode: _phoneFocusNode,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      initialCountryCode: 'ZW',
      onChanged: (PhoneNumber phone) {
        _completePhoneNumber = phone.number;
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Length (cm)', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Width (cm)', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Height (cm)', style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDimensionSpinBox(
              value: _length,
              step: 5,
              onChanged:
                  (value) => setState(() {
                    _length = value;
                    widget.parcelShipment.length = value;
                    _updateShippingCost();
                  }),
            ),
            const SizedBox(width: 10),
            _buildDimensionSpinBox(
              value: _width,
              step: 5,
              onChanged:
                  (value) => setState(() {
                    _width = value;
                    widget.parcelShipment.width = value;
                    _updateShippingCost();
                  }),
            ),
            const SizedBox(width: 10),
            _buildDimensionSpinBox(
              value: _height,
              step: 5,
              onChanged:
                  (value) => setState(() {
                    _height = value;
                    widget.parcelShipment.height = value;
                    _updateShippingCost();
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Mass (kg)', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Units', style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDimensionSpinBox(
              value: _mass,
              step: 0.5,
              onChanged:
                  (value) => setState(() {
                    _mass = value;
                    widget.parcelShipment.mass = value;
                    _updateShippingCost();
                  }),
            ),
            const SizedBox(width: 10),
            _buildDimensionSpinBox(
              value: _quantity,
              step: 1.0,
              onChanged:
                  (value) => setState(() {
                    _quantity = value;
                    _updateShippingCost();
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
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('\$${_shippingCost.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDimensionSpinBox({
    required double value,
    required double step,
    required ValueChanged<double> onChanged,
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
