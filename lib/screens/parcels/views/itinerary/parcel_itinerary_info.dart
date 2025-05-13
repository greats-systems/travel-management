import 'package:flutter/material.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class ParcelItineraryInfo extends StatefulWidget {
  final ParcelShipment parcel;
  const ParcelItineraryInfo({super.key, required this.parcel});

  @override
  State<ParcelItineraryInfo> createState() => _ParcelItineraryInfoState();
}

class _ParcelItineraryInfoState extends State<ParcelItineraryInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cargo Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Cargo information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            MySizedBox(),
            _buildCargoDetails(),
            MySizedBox(),
            _buildPricingDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildCargoDetails() {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.parcel.name!),
                    Chip(
                      label: Text(widget.parcel.status!.toUpperCase()),
                      backgroundColor:
                          widget.parcel.status == 'In transit'
                              ? Colors.yellow
                              : Colors.green,
                    ),
                  ],
                ),
                MySizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From', style: TextStyle(color: Colors.grey)),
                        Text(widget.parcel.origin!),
                      ],
                    ),
                    Image.asset(
                      constants.returnCourierLogo(widget.parcel.courierName!)!,
                      width: 60,
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('To', style: TextStyle(color: Colors.grey)),
                        Text(widget.parcel.destination!),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPricingDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            MySizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price:'),
                Text('\$${widget.parcel.shippingCost!.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Receipted on:'),
                Text(constants.formatDateTime(widget.parcel.createdAt!)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
