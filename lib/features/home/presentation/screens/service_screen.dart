import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/home/presentation/cubit/packages_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_bottom_sheet.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_option.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/service_filters_section.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/service_results_section.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/service_screen_header_section.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String _selectedFilter = "All";
  FilterOptions _filterOptions = const FilterOptions(
    budgetRange: RangeValues(0, 300),
  );
  bool _didSetInitialRange = false;

  bool _hasActiveFilters(double minPrice, double maxPrice) {
    return _filterOptions.selectedCity != null ||
        _selectedFilter != 'All' ||
        _filterOptions.budgetRange.start > minPrice ||
        _filterOptions.budgetRange.end < maxPrice;
  }

  Future<void> _loadPackagesWithFilters(
    PackagesState state,
    PackagesCubit cubit, {
    int page = 1,
  }) async {
    final categoryId = _selectedFilter == 'All'
        ? null
        : state.categories
              .where((category) => category.name == _selectedFilter)
              .map((category) => category.id)
              .cast<int?>()
              .firstWhere((id) => id != null, orElse: () => null);

    final placeId = _filterOptions.selectedCity == null
        ? null
        : state.places
              .where((place) => place.title == _filterOptions.selectedCity)
              .map((place) => place.id)
              .cast<int?>()
              .firstWhere((id) => id != null, orElse: () => null);

    await cubit.getPackages(
      categoryId: categoryId,
      placeId: placeId,
      minPrice: _filterOptions.budgetRange.start,
      maxPrice: _filterOptions.budgetRange.end,
      page: page,
    );
  }

  void _openFilterSheet(
    BuildContext context,
    double minPrice,
    double maxPrice,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FilterBottomSheet(
          initialOptions: _filterOptions,
          places: context
              .read<PackagesCubit>()
              .state
              .places
              .map((place) => place.title)
              .where((title) => title.isNotEmpty)
              .toSet()
              .map(
                (title) => {'name': title, 'icon': Icons.location_on_outlined},
              )
              .toList(),
          minBudget: minPrice,
          maxBudget: maxPrice,
          onApply: (options) async {
            setState(() => _filterOptions = options);
            await _loadPackagesWithFilters(
              context.read<PackagesCubit>().state,
              context.read<PackagesCubit>(),
              page: 1,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackagesCubit, PackagesState>(
      listener: (context, state) {
        if (!_didSetInitialRange && state.status.isSuccess) {
          _didSetInitialRange = true;
          setState(() {
            _filterOptions = _filterOptions.copyWith(
              budgetRange: RangeValues(state.minPrice, state.maxPrice),
            );
          });
        }
      },
      builder: (context, state) {
        final minPrice = state.minPrice;
        final maxPrice = state.maxPrice;
        final hasActiveFilters = _hasActiveFilters(minPrice, maxPrice);
        final filters = [
          'All',
          ...state.categories
              .map((category) => category.name)
              .where((name) => name.isNotEmpty)
              .toSet(),
        ];

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ServiceScreenHeaderSection(),
                  ServiceFiltersSection(
                    hasActiveFilters: hasActiveFilters,
                    selectedFilter: _selectedFilter,
                    filterOptions: _filterOptions,
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                    filters: filters,
                    onOpenFilter: () =>
                        _openFilterSheet(context, minPrice, maxPrice),
                    onRemoveCategory: () async {
                      setState(() => _selectedFilter = 'All');
                      await _loadPackagesWithFilters(
                        state,
                        context.read<PackagesCubit>(),
                        page: 1,
                      );
                    },
                    onRemovePlace: () async {
                      setState(() {
                        _filterOptions = _filterOptions.copyWith(
                          clearCity: true,
                        );
                      });
                      await _loadPackagesWithFilters(
                        state,
                        context.read<PackagesCubit>(),
                        page: 1,
                      );
                    },
                    onRemoveBudget: () async {
                      setState(() {
                        _filterOptions = _filterOptions.copyWith(
                          budgetRange: RangeValues(minPrice, maxPrice),
                        );
                      });
                      await _loadPackagesWithFilters(
                        state,
                        context.read<PackagesCubit>(),
                        page: 1,
                      );
                    },
                    onFilterChanged: (newFilter) async {
                      setState(() => _selectedFilter = newFilter);
                      await _loadPackagesWithFilters(
                        state,
                        context.read<PackagesCubit>(),
                        page: 1,
                      );
                    },
                  ),
                  ServiceResultsSection(
                    status: state.status,
                    errorMessage: state.errorMessage,
                    packages: state.packages,
                    currentPage: state.currentPage,
                    totalPages: state.totalPages,
                    onPageChanged: (page) async {
                      await _loadPackagesWithFilters(
                        state,
                        context.read<PackagesCubit>(),
                        page: page,
                      );
                    },
                    onReviewSubmitted: () async {
                      final cubit = context.read<PackagesCubit>();
                      final latestState = cubit.state;
                      await _loadPackagesWithFilters(
                        latestState,
                        cubit,
                        page: latestState.currentPage,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
