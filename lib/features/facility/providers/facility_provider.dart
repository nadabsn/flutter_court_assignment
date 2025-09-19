import 'package:flutter/foundation.dart';

import '../../../core/common/models/facility.dart';
import '../service/facility_service.dart';

class FacilityProvider extends ChangeNotifier {
  final FacilityService _facilityService;

  FacilityProvider(this._facilityService);

  // State
  bool _isLoading = false;
  List<Facility> _allFacilities = [];
  List<Facility> _filteredFacilities = [];
  String _errorMessage = '';
  String _searchQuery = '';
  String? _selectedSport;

  // Available sports for filtering
  final List<String> _availableSports = [
    'football',
    'padel',
    'tennis',
    'basketball',
    'swimming',
    'volleyball',
    'karting',
  ];

  // Getters
  bool get isLoading => _isLoading;

  List<Facility> get allFacilities => _allFacilities;

  List<Facility> get facilities => _filteredFacilities;

  String get errorMessage => _errorMessage;

  String get searchQuery => _searchQuery;

  String? get selectedSport => _selectedSport;

  List<String> get availableSports => _availableSports;

  bool get isEmpty => _filteredFacilities.isEmpty && !_isLoading;

  // Public methods
  Future<void> loadFacilities() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allFacilities = await _facilityService.getFacilities();
      _applyFilters();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshFacilities() async {
    try {
      _isLoading = true;
      _allFacilities = await _facilityService.getFacilities();
      _applyFilters();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchFacilities(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterBySport(String? sport) {
    _selectedSport = sport;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedSport = null;
    _applyFilters();
  }

  void retryLoading() {
    loadFacilities();
  }

  // Private methods
  void _applyFilters() {
    _filteredFacilities =
        _allFacilities.where((facility) {
          // Text search filter
          bool matchesSearch =
              _searchQuery.isEmpty ||
              facility.name.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              facility.city.toLowerCase().contains(_searchQuery.toLowerCase());

          // Sport filter
          bool matchesSport =
              _selectedSport == null ||
              facility.sports.contains(_selectedSport);

          return matchesSearch && matchesSport;
        }).toList();

    notifyListeners();
  }
}
