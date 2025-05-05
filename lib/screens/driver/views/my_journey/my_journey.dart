import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    // Delay slightly to ensure build is complete
    await Future.delayed(Duration.zero);
    final journeyService = Provider.of<JourneyService>(context, listen: false);
    await journeyService.fetchUserJourney(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final journeyService = Provider.of<JourneyService>(context);

    return Scaffold(body: _buildBody(journeyService));
  }

  Widget _buildBody(JourneyService journeyService) {
    if (journeyService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (journeyService.error != null) {
      return Center(child: Text('Error: ${journeyService.error}'));
    }

    if (!journeyService.hasCheckedForJourney) {
      return const Center(child: CircularProgressIndicator());
    }

    if (journeyService.currentJourney == null) {
      return const Center(child: Text('No active journeys found'));
    }

    return JourneyMap(journey: journeyService.currentJourney!);
  }
}
