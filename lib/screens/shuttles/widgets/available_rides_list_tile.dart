import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/models/ride_route.dart';

class AvailableRidesListTile extends StatelessWidget {
  final List<RideRoute>? rideRoutes;
  const AvailableRidesListTile({super.key, required this.rideRoutes});

  Widget _buildListTile(RideRoute route, BuildContext context) {
    return ListTile(
      title: Text(route.origin!),
      subtitle: Text(route.destination!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: rideRoutes?.length ?? 0,
            itemBuilder: ((context, index) {
              final shuttle = rideRoutes![index];
              return ListTile(title: _buildListTile(shuttle, context));
            }),
          ),
        ),
      ],
    );
  }
}
