import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core/common/models/facility.dart';

class FacilityService {
  static const String _facilitiesPath = 'assets/facilities.json';

  // Simulate network delay
  static const Duration _networkDelay = Duration(milliseconds: 800);

  Future<List<Facility>> getFacilities() async {
    await Future.delayed(_networkDelay);

    // Load the Mock data from assets
    final String jsonString = await rootBundle.loadString(_facilitiesPath);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> facilitiesJson = jsonData['facilities'] ?? [];

    return facilitiesJson
        .map((facilityJson) => Facility.fromJson(facilityJson))
        .toList();
  }
}
