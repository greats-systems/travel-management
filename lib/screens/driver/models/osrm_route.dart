class OSRMRoute {
  final Map<String, dynamic> geometry;
  final double distance;
  final double duration;
  final List<dynamic> waypoints;

  OSRMRoute({
    required this.geometry,
    required this.distance,
    required this.duration,
    required this.waypoints,
  });

  factory OSRMRoute.fromMap(Map<String, dynamic> json) {
    return OSRMRoute(
      geometry: json['geometry'],
      distance: (json['distance'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
      waypoints: json['waypoints'],
    );
  }
}
