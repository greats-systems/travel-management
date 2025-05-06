import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_management_app_2/screens/driver/models/journey.dart';
import 'package:travel_management_app_2/screens/driver/widgets/journey_map.dart';
import 'package:travel_management_app_2/services/journey_service.dart';

class MyJourney extends StatefulWidget {
  final String userId;

  const MyJourney({super.key, required this.userId});

  @override
  State<MyJourney> createState() => _MyJourneyState();
}

class _MyJourneyState extends State<MyJourney> {
  @override
  void initState() {
    super.initState();
    _loadJourney();
  }

  Future<void> _loadJourney() async {
    await Future.delayed(Duration.zero); // Ensure build is complete
    final journeyService = Provider.of<JourneyService>(context, listen: false);
    await journeyService.fetchUserJourney(widget.userId);
  }

  // Helper method to check if a journey is actually active
  bool _isJourneyActive(Journey? journey) {
    if (journey == null) return false;

    return journey.userID != null &&
        journey.origin != null &&
        journey.destination != null &&
        journey.currentLocationLat != null &&
        journey.currentLocationLong != null;
  }

  @override
  Widget build(BuildContext context) {
    final journeyService = Provider.of<JourneyService>(context);

    return Scaffold(body: _buildBody(journeyService));
  }

  Widget _buildBody(JourneyService journeyService) {
    if (journeyService.isLoading || !journeyService.hasCheckedForJourney) {
      return const Center(child: CircularProgressIndicator());
    }

    if (journeyService.error != null) {
      return Center(child: Text('Error: ${journeyService.error}'));
    }

    if (!_isJourneyActive(journeyService.currentJourney)) {
      return const Center(child: Text('No active journeys found'));
    }

    return JourneyMap(journey: journeyService.currentJourney!);
  }
}
