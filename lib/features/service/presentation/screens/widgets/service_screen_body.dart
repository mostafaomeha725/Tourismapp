import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourismapp/features/service/presentation/cubit/packages_cubit.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_option.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/service_filters_section.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/service_results_section.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/service_screen_header_section.dart';

class ServiceScreenBody extends StatelessWidget {
  final PackagesState state;
  final bool hasActiveFilters;
  final bool showAppliedBudgetChip;
  final String selectedFilter;
  final FilterOptions filterOptions;
  final double minPrice;
  final double maxPrice;
  final ScrollController resultsScrollController;
  final List<String> filters;
  final VoidCallback onOpenFilter;
  final Future<void> Function() onRemoveCategory;
  final Future<void> Function() onRemovePlace;
  final Future<void> Function() onRemoveBudget;
  final Future<void> Function() onRemoveSort;
  final Future<void> Function(String newFilter) onFilterChanged;
  final Future<void> Function(int page) onPageChanged;
  final Future<void> Function() onReviewSubmitted;
  final Future<void> Function() onRetry;

  const ServiceScreenBody({
    super.key,
    required this.state,
    required this.hasActiveFilters,
    required this.showAppliedBudgetChip,
    required this.selectedFilter,
    required this.filterOptions,
    required this.minPrice,
    required this.maxPrice,
    required this.resultsScrollController,
    required this.filters,
    required this.onOpenFilter,
    required this.onRemoveCategory,
    required this.onRemovePlace,
    required this.onRemoveBudget,
    required this.onRemoveSort,
    required this.onFilterChanged,
    required this.onPageChanged,
    required this.onReviewSubmitted,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          controller: resultsScrollController,
          child: Column(
            children: [
              const ServiceScreenHeaderSection(),
              ServiceFiltersSection(
                hasActiveFilters: hasActiveFilters,
                showAppliedBudgetChip: showAppliedBudgetChip,
                selectedFilter: selectedFilter,
                filterOptions: filterOptions,
                minPrice: minPrice,
                maxPrice: maxPrice,
                filters: filters,
                onOpenFilter: onOpenFilter,
                onRemoveCategory: () {
                  onRemoveCategory();
                },
                onRemovePlace: () {
                  onRemovePlace();
                },
                onRemoveBudget: () {
                  onRemoveBudget();
                },
                onRemoveSort: () {
                  onRemoveSort();
                },
                onFilterChanged: (newFilter) {
                  onFilterChanged(newFilter);
                },
              ),
              ServiceResultsSection(
                status: state.status,
                errorMessage: state.errorMessage,
                packages: state.packages,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                onPageChanged: (page) {
                  onPageChanged(page);
                },
                onReviewSubmitted: onReviewSubmitted,
                onRetry: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
