import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/features/service/domain/usecases/get_packages_usecase.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_bottom_sheet_budget_section.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_bottom_sheet_header.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_bottom_sheet_location_section.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_option.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_bottom_sheet_sort_section.dart';

class FilterBottomSheet extends StatefulWidget {
  final FilterOptions initialOptions;
  final ValueChanged<FilterOptions> onApply;
  final List<Map<String, dynamic>> places;
  final bool isLocationLoading;
  final double minBudget;
  final double maxBudget;

  const FilterBottomSheet({
    super.key,
    required this.initialOptions,
    required this.onApply,
    required this.places,
    required this.isLocationLoading,
    required this.minBudget,
    required this.maxBudget,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String? _selectedCity;
  late RangeValues _budgetRange;
  late PackagesSortOption _selectedSort;

  late double _minBudget;
  late double _maxBudget;

  @override
  void initState() {
    super.initState();
    _minBudget = widget.minBudget;
    _maxBudget = widget.maxBudget <= widget.minBudget
        ? widget.minBudget + 1
        : widget.maxBudget;
    _selectedCity = widget.initialOptions.selectedCity;
    _selectedSort = widget.initialOptions.sort;
    final start = widget.initialOptions.budgetRange.start.clamp(
      _minBudget,
      _maxBudget,
    );
    final end = widget.initialOptions.budgetRange.end.clamp(
      _minBudget,
      _maxBudget,
    );
    _budgetRange = RangeValues(
      start.toDouble(),
      end.toDouble() < start.toDouble() ? start.toDouble() : end.toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterBottomSheetHeader(
            onReset: () {
              setState(() {
                _selectedCity = null;
                _budgetRange = RangeValues(_minBudget, _maxBudget);
                _selectedSort = PackagesSortOption.newest;
              });
            },
          ),

          SizedBox(height: 24.h),

          FilterBottomSheetLocationSection(
            places: widget.places,
            isLoading: widget.isLocationLoading,
            selectedCity: _selectedCity,
            onCityTap: (cityName) {
              final bool isSelected = _selectedCity == cityName;
              setState(() {
                _selectedCity = isSelected ? null : cityName;
              });
            },
          ),

          SizedBox(height: 28.h),

          FilterBottomSheetSortSection(
            selectedSort: _selectedSort,
            onSortSelected: (sortOption) {
              setState(() {
                _selectedSort = sortOption;
              });
            },
          ),

          SizedBox(height: 28.h),

          FilterBottomSheetBudgetSection(
            budgetRange: _budgetRange,
            minBudget: _minBudget,
            maxBudget: _maxBudget,
            onChanged: (values) {
              setState(() {
                _budgetRange = values;
              });
            },
          ),

          SizedBox(height: 28.h),

          AppButton(
            text: 'Apply Filters',
            color: const Color(0xffdb6000),
            height: 52.h,
            radius: 22.r,
            onPressed: () {
              widget.onApply(
                FilterOptions(
                  selectedCity: _selectedCity,
                  budgetRange: _budgetRange,
                  sort: _selectedSort,
                ),
              );
              GoRouter.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
