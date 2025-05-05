import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:travel_management_app_2/screens/driver/controllers/driver_controller.dart';
import 'package:travel_management_app_2/screens/driver/models/journey.dart';

class JourneyService with ChangeNotifier {
  Journey? _currentJourney;
  bool _isLoading = false;
  String? _error;
  bool _hasCheckedForJourney = false;

  // Getters
  Journey? get currentJourney => _currentJourney;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasCheckedForJourney => _hasCheckedForJourney;

  final DriverController _driverController = DriverController();

  Future<void> fetchUserJourney(String userID) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    _safeNotifyListeners();

    try {
      final journey = await _driverController.getJourneyFromSupabase(userID);
      _currentJourney = journey;
      _hasCheckedForJourney = true;
      _safeNotifyListeners();

      log('Journey loaded: ${JsonEncoder.withIndent(' ').convert(journey)}');
    } catch (e, stackTrace) {
      _error = 'Failed to load journey';
      _hasCheckedForJourney = true;
      _safeNotifyListeners();
      log('Error fetching journey', error: e, stackTrace: stackTrace);
    } finally {
      _isLoading = false;
      _safeNotifyListeners();
    }
  }

  void clearJourney() {
    _currentJourney = null;
    _hasCheckedForJourney = false;
    _error = null;
    _safeNotifyListeners();
  }

  void _safeNotifyListeners() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      // If we're in the build phase, delay notification
      SchedulerBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } else {
      // Otherwise notify immediately
      notifyListeners();
    }
  }
}
