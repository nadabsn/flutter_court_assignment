import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:test_assignment_flutter/core/common/widgets/custom_loader.dart';
import 'package:test_assignment_flutter/core/config/app_responsive_config.dart';
import 'package:test_assignment_flutter/features/facility/providers/facility_provider.dart';
import 'package:test_assignment_flutter/features/home/widgets/facility_card.dart';

import '../../../core/common/models/facility.dart';
import '../../../core/common/widgets/empty_state.dart';
import '../../../core/helpers/snackbar_helper.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';

class FacilitiesListScreen extends StatefulWidget {
  const FacilitiesListScreen({super.key});

  @override
  State<FacilitiesListScreen> createState() => _FacilitiesListScreenState();
}

class _FacilitiesListScreenState extends State<FacilitiesListScreen> {
  List<Facility> _allFacilities = [];
  List<Facility> _filteredFacilities = [];
  String _searchQuery = '';
  String? _selectedSport;
  final TextEditingController _searchController = TextEditingController();

  // Available sports for filtering
  final List<String> _availableSports = [
    'football',
    'padel',
    'tennis',
    'basketball',
    'swimming',
    'volleyball',
    'karting'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFacilities();
    });
  }

  Future<void> _loadFacilities() async {
    try {
      FacilityProvider facilityProvider =
          Provider.of<FacilityProvider>(context, listen: false);
      await facilityProvider.loadFacilities();
      _allFacilities = facilityProvider.allFacilities;
      _applyFilters();
    } catch (e) {
      if (!mounted) return;
      CustomSnackbar.show(
        context,
        message: "Failed to load facilities. Please try again.",
        type: SnackbarType.error,
      );
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredFacilities = _allFacilities.where((facility) {
        // Text search filter
        bool matchesSearch = _searchQuery.isEmpty ||
            facility.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            facility.city.toLowerCase().contains(_searchQuery.toLowerCase());

        // Sport filter
        bool matchesSport =
            _selectedSport == null || facility.sports.contains(_selectedSport);

        return matchesSearch && matchesSport;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _onSportFilterChanged(String? sport) {
    _selectedSport = sport;
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FacilityProvider>(
        builder: (context, facilityProvider, child) {
      return ModalProgressHUD(
        inAsyncCall: facilityProvider.isLoading,
        blur: 5,
        progressIndicator: const CustomLoader(),
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.gradientBgStart, AppColors.gradientBgEnd],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CourtBook', style: AppTextStyles.headline),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Find your perfect court',
                                style: AppTextStyles.muted),
                            GestureDetector(
                              child: ElevatedButton(
                                onPressed: () {
                                  context.push('/bookings');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
                                ),
                                child: Text('Bookings',
                                    style: AppTextStyles.smallText),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),

                        // Search Bar
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            style: AppTextStyles.subtitle,
                            decoration: InputDecoration(
                              hintText: 'Search facilities...',
                              hintStyle: AppTextStyles.muted,
                              prefixIcon: const Icon(Icons.search,
                                  color: AppColors.mutedWhite),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.w),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Sport Filter Chips
                        SizedBox(
                          height: 40.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildFilterChip('All Sports', null),
                              ..._availableSports
                                  .map((sport) => _buildFilterChip(
                                        sport.toUpperCase(),
                                        sport,
                                      )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: _filteredFacilities.isEmpty &&
                            !facilityProvider.isLoading
                        ? EmptyState(
                            title: "No courts available",
                            subtitle: "Please check back later",
                          )
                        : _buildFacilitiesList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFilterChip(String label, String? value) {
    final isSelected = _selectedSport == value;
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => _onSportFilterChanged(value),
        backgroundColor: AppColors.card,
        selectedColor: AppColors.accent,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.background : AppColors.white,
          fontSize: 12.w,
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide.none,
      ),
    );
  }

  Widget _buildFacilitiesList() {
    return RefreshIndicator(
      onRefresh: _loadFacilities,
      color: AppColors.accent,
      backgroundColor: AppColors.card,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _filteredFacilities.length,
        itemBuilder: (context, index) {
          return FacilityCard(facility: _filteredFacilities[index]);
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
