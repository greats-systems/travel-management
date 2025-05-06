import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_management_app_2/screens/shuttles/models/ride.dart';

class AvailableRidesMap extends StatefulWidget {
  final List<Ride> rides;
  final String userId;
  const AvailableRidesMap({
    super.key,
    required this.rides,
    required this.userId,
  });

  @override
  State<AvailableRidesMap> createState() => _AvailableRidesMapState();
}

class _AvailableRidesMapState extends State<AvailableRidesMap> {
  late List<Marker> _markers = [];
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _initializeMarkers();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  bool _isValidCoordinate(double? coordinate) {
    return coordinate != null &&
        coordinate.isFinite &&
        !coordinate.isNaN &&
        coordinate >= -180 &&
        coordinate <= 180;
  }

  void _initializeMarkers() {
    if (_isDisposed) return;

    final newMarkers = <Marker>[];

    for (final ride in widget.rides) {
      // Skip if coordinates are invalid
      if (!_isValidCoordinate(ride.driverPositionLat) ||
          !_isValidCoordinate(ride.driverPositionLong)) {
        debugPrint('Skipping invalid coordinates for ride ${ride.driverID}');
        continue;
      }

      final location = LatLng(
        ride.driverPositionLat!,
        ride.driverPositionLong!,
      );

      newMarkers.add(
        Marker(
          point: location,
          width: 40,
          height: 40,
          child: Icon(
            Icons.directions_car,
            size: 30,
            color: Colors.blue.shade500,
          ),
        ),
      );
    }

    if (mounted) {
      setState(() => _markers = newMarkers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(
          -19.58498215,
          29.002645954,
        ), // Default center
        initialZoom: 6.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          maxZoom: 19,
          minZoom: 1,
        ),
        MarkerLayer(markers: _markers),
      ],
    );
  }
}
