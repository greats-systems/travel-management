import 'package:flutter/material.dart';
// import 'package:travel_management_app_2/screens/shuttles/models/shuttle.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/shuttles/models/shuttle_route.dart';
import 'package:travel_management_app_2/screens/shuttles/views/available_shuttles/buses/shuttle_services_info.dart';

class AvailableShuttleServicesListTile extends StatelessWidget {
  final String departureDate;
  final List<ShuttleRoute>? shuttleRoutes;

  const AvailableShuttleServicesListTile({
    super.key,
    required this.shuttleRoutes,
    required this.departureDate,
  });

  Widget _buildShuttleServiceListTile(
    ShuttleRoute shuttleRoute,
    BuildContext context,
  ) {
    final String logoURL =
        constants.returnShuttleCompanyLogo(
          shuttleRoute.shuttleServiceCompany!['name'],
        )!;
    return ListTile(
      leading: Image.asset(logoURL, width: 40, height: 40),
      title: Text(shuttleRoute.shuttleServiceCompany!['name']),
      subtitle: Text('${shuttleRoute.origin} to ${shuttleRoute.destination}'),
      onTap:
          () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ShuttleServicesInfo(
                      shuttleRoute: shuttleRoute,
                      departureDate: departureDate,
                    ),
              ),
            ),
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: shuttleRoutes?.length ?? 0,
            itemBuilder: ((context, index) {
              final shuttle = shuttleRoutes![index];
              return ListTile(
                title: _buildShuttleServiceListTile(shuttle, context),
              );
            }),
          ),
        ),
      ],
    );
  }
}
