import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/home/presentation/cubit/packages_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_bottom_sheet.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_option.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/service_screen_body.dart';

part 'widgets/service_screen_filters_logic.dart';
part 'widgets/service_screen_interactions.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String _selectedFilter = "All";
  late FilterOptions _filterOptions;
  bool _didSetInitialRange = false;
  bool _isBudgetApplied = false;

  bool _isBudgetFilterActive(double minPrice, double maxPrice) {
    const epsilon = 0.0001;
    return (_filterOptions.budgetRange.start - minPrice).abs() > epsilon ||
        (_filterOptions.budgetRange.end - maxPrice).abs() > epsilon;
  }

  void _withStateUpdate(VoidCallback updater) {
    setState(updater);
  }

  @override
  void initState() {
    super.initState();
    final state = context.read<PackagesCubit>().state;
    _filterOptions = FilterOptions(
      budgetRange: RangeValues(state.minPrice, state.maxPrice),
    );
    _didSetInitialRange = state.status.isSuccess;
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

        return ServiceScreenBody(
          state: state,
          hasActiveFilters: hasActiveFilters,
          showAppliedBudgetChip:
              _isBudgetApplied || _isBudgetFilterActive(minPrice, maxPrice),
          selectedFilter: _selectedFilter,
          filterOptions: _filterOptions,
          minPrice: minPrice,
          maxPrice: maxPrice,
          filters: filters,
          onOpenFilter: () => _openFilterSheet(context, minPrice, maxPrice),
          onRemoveCategory: () => _onRemoveCategory(state),
          onRemovePlace: () => _onRemovePlace(state),
          onRemoveBudget: () => _onRemoveBudget(state, minPrice, maxPrice),
          onFilterChanged: (newFilter) => _onFilterChanged(state, newFilter),
          onPageChanged: (page) => _onPageChanged(state, page),
          onReviewSubmitted: _onReviewSubmitted,
        );
      },
    );
  }
}
