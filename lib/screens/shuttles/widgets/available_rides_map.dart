import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_management_app_2/screens/driver/controllers/driver_controller.dart';
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
  List<Location>? geocodedOrigin;
  List<Location>? geocodedDestination;
  bool _isDisposed = false;
  List<LatLng> _routePoints = [];
  LatLng? _mapCenter;
  TileLayer get osmTileLayer => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'com.example.app',
  );

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

  Future<void> _fetchRoute(LatLng origin, LatLng destination) async {
    try {
      final route = await DriverController().getRoute(origin, destination);

      if (_isDisposed) return;

      if (route != null) {
        final coordinates = route.geometry['coordinates'] as List;
        final routePoints =
            coordinates
                .map(
                  (coord) => LatLng(
                    (coord[1] as num).toDouble(),
                    (coord[0] as num).toDouble(),
                  ),
                )
                .toList();

        if (mounted) {
          setState(() {
            _routePoints = routePoints;
            _mapCenter = LatLng(
              (origin.latitude + destination.latitude) / 2,
              (origin.longitude + destination.longitude) / 2,
            );
          });
        }
      }
    } catch (e) {
      log('Error fetching route: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to load route')));
      }
    }
  }

  void _initializeMarkers() async {
    if (_isDisposed) return;

    final newMarkers = <Marker>[];
    try {
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

        geocodedOrigin = await locationFromAddress(ride.origin!);
        geocodedDestination = await locationFromAddress(ride.destination!);

        if (geocodedOrigin == null ||
            geocodedOrigin!.isEmpty ||
            geocodedDestination == null ||
            geocodedDestination!.isEmpty) {
          throw Exception('Could not geocode addresses');
        }

        final originLatLng = LatLng(
          geocodedOrigin![0].latitude,
          geocodedOrigin![0].longitude,
        );
        final destLatLng = LatLng(
          geocodedDestination![0].latitude,
          geocodedDestination![0].longitude,
        );

        newMarkers.addAll([
          Marker(
            point: originLatLng,
            width: 40,
            height: 40,
            child: Icon(
              Icons.location_pin,
              size: 40,
              color: Colors.red.shade500,
            ),
          ),
          Marker(
            point: destLatLng,
            width: 40,
            height: 40,
            child: Icon(
              Icons.location_pin,
              size: 40,
              color: Colors.red.shade500,
            ),
          ),
          Marker(
            point: location,
            width: 40,
            height: 40,
            child: Icon(Icons.directions_car),
          ),
        ]);
        await _fetchRoute(originLatLng, destLatLng);
        if (mounted) {
          setState(() => _markers = newMarkers);
        }
      }
    } catch (e) {
      log('Error creating markers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _mapCenter ?? const LatLng(-19.58498215, 29.002645954),
        initialZoom: _mapCenter != null ? 10 : 6,
      ),
      children: [
        osmTileLayer,
        if (_routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                color: Colors.blue.shade500,
                strokeWidth: 4,
              ),
            ],
          ),
        MarkerLayer(markers: _markers),
      ],
    );
  }
}
