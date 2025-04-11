import 'package:flutter/material.dart';
import 'package:travel_management_app_2/screens/shuttles/models/shuttle.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/shuttles/views/shuttle_services_info/shuttle_services_info.dart';

class AvailableShuttleServicesListTile extends StatelessWidget {
  final List<Shuttle>? shuttles;

  const AvailableShuttleServicesListTile({super.key, this.shuttles});

  Widget _buildShuttleServiceListTile(Shuttle shuttle, BuildContext context) {
    final String logoURL =
        constants.returnShuttleCompanyLogo(shuttle.companyName!)!;
    return ListTile(
      leading: Image.asset(logoURL, width: 40, height: 40),
      title: Text(
        shuttle.companyName!,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(shuttle.address!),
      onTap:
          () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShuttleServicesInfo(shuttle: shuttle),
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
            itemCount: shuttles?.length ?? 0,
            itemBuilder: ((context, index) {
              final shuttle = shuttles![index];
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
