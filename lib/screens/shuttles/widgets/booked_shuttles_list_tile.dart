import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_booking.dart';
import 'package:travel_management_app_2/screens/shuttles/views/itinerary/shuttle_itinerary_info.dart';

class BookedShuttlesListTile extends StatelessWidget {
  final List<ShuttleBooking>? shuttleBookings;
  final String userId;
  const BookedShuttlesListTile({
    super.key,
    required this.shuttleBookings,
    required this.userId,
  });

  Widget buildBookingListTile(
    ShuttleBooking shuttleBooking,
    BuildContext context,
  ) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    ShuttleItineraryInfo(shuttleBooking: shuttleBooking),
          ),
        );
      },
      leading: Image.asset(
        constants.returnShuttleCompanyLogo(shuttleBooking.companyName)!,
        width: 40,
        height: 40,
      ),
      title: Text('${shuttleBooking.origin} → ${shuttleBooking.destination}'),
      subtitle: Text(shuttleBooking.companyName!),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('\$${shuttleBooking.amountPaid!.toStringAsFixed(2)}')],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: shuttleBookings!.length,
            itemBuilder: (context, index) {
              final shuttleBooking = shuttleBookings![index];
              return ListTile(
                title: buildBookingListTile(shuttleBooking, context),
              );
            },
          ),
        ),
      ],
    );
  }
}
