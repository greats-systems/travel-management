import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_management_app_2/components/my_snack_bar.dart';
import 'package:travel_management_app_2/screens/driver/controllers/driver_controller.dart';
import 'package:travel_management_app_2/screens/driver/models/journey.dart';

class JourneyMap extends StatefulWidget {
  final Journey? journey;
  const JourneyMap({super.key, this.journey});

  @override
  State<JourneyMap> createState() => _JourneyMapState();
}

class _JourneyMapState extends State<JourneyMap> {
  List<Location>? geocodedOrigin;
  List<Location>? geocodedDestination;
  final List<Marker> _markers = [];
  List<LatLng> _routePoints = [];
  LatLng? _mapCenter;
  bool _isDisposed = false;

  TileLayer get osmTileLayer => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'com.example.app',
  );

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
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

  Future<void> createMarkers() async {
    if (widget.journey == null ||
        widget.journey!.origin == null ||
        widget.journey!.destination == null) {
      if (mounted) {
        MySnackBar.showSnackBar(
          context,
          'Journey data is incomplete',
          Colors.yellow,
        );
      }
      return;
    }

    try {
      geocodedOrigin = await locationFromAddress(widget.journey!.origin!);
      geocodedDestination = await locationFromAddress(
        widget.journey!.destination!,
      );

      if (_isDisposed) return;

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

      if (mounted) {
        setState(() {
          _markers.addAll([
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
          ]);
        });
      }

      await _fetchRoute(originLatLng, destLatLng);
    } catch (e) {
      log('Error creating markers: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        createMarkers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
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
      ),
    );
  }
}
