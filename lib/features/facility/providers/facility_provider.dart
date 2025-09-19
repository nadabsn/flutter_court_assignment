import 'package:flutter/foundation.dart';

import '../../../core/common/models/facility.dart';
import '../service/facility_service.dart';

class FacilityProvider extends ChangeNotifier {
  final FacilityService _facilityService;

  FacilityProvider(this._facilityService);

  // State
  bool _isLoading = false;
  List<Facility> _allFacilities = [];
  String _errorMessage = '';

  // Getters
  bool get isLoading => _isLoading;

  List<Facility> get allFacilities => _allFacilities;

  String get errorMessage => _errorMessage;

  // Public methods
  Future<void> loadFacilities() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allFacilities = await _facilityService.getFacilities();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
