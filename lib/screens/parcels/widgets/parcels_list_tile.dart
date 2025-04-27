import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/parcels/models/parcel_shipment.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/parcels/views/itinerary/parcel_itinerary_info.dart';

class ParcelsListTile extends StatelessWidget {
  final List<ParcelShipment> parcels;
  const ParcelsListTile({super.key, required this.parcels});

  Widget _buildParcelsTile(ParcelShipment parcel, BuildContext context) {
    return ListTile(
      leading: Image.asset(
        constants.returnCourierLogo(parcel.courierName!)!,
        width: 40,
        height: 40,
      ),
      title: Text(parcel.name!),
      subtitle: Text('${parcel.origin} → ${parcel.destination}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParcelItineraryInfo(parcel: parcel),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: parcels.length,
            itemBuilder: (context, index) {
              final parcel = parcels[index];
              return ListTile(title: _buildParcelsTile(parcel, context));
            },
          ),
        ),
      ],
    );
  }
}
