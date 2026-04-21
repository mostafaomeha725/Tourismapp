part of '../service_screen.dart';

extension _ServiceScreenInteractions on _ServiceScreenState {
  Future<void> _onRemoveCategory(PackagesState state) async {
    _withStateUpdate(() => _selectedFilter = 'All');
    await _loadPackagesWithFilters(
      state,
      context.read<PackagesCubit>(),
      page: 1,
    );
  }

  Future<void> _onRemovePlace(PackagesState state) async {
    _withStateUpdate(() {
      _filterOptions = _filterOptions.copyWith(clearCity: true);
    });
    await _loadPackagesWithFilters(
      state,
      context.read<PackagesCubit>(),
      page: 1,
    );
  }

  Future<void> _onRemoveBudget(
    PackagesState state,
    double minPrice,
    double maxPrice,
  ) async {
    _withStateUpdate(() {
      _isBudgetApplied = false;
      _filterOptions = _filterOptions.copyWith(
        budgetRange: RangeValues(minPrice, maxPrice),
      );
    });
    await _loadPackagesWithFilters(
      state,
      context.read<PackagesCubit>(),
      page: 1,
    );
  }

  Future<void> _onSortChanged(
    PackagesState state,
    PackagesSortOption sort,
  ) async {
    _withStateUpdate(() {
      _filterOptions = _filterOptions.copyWith(sort: sort);
    });
    await _loadPackagesWithFilters(
      state,
      context.read<PackagesCubit>(),
      page: 1,
    );
  }

  Future<void> _onFilterChanged(PackagesState state, String newFilter) async {
    _withStateUpdate(() => _selectedFilter = newFilter);
    await _loadPackagesWithFilters(
      state,
      context.read<PackagesCubit>(),
      page: 1,
    );
  }

  Future<void> _onPageChanged(PackagesState state, int page) async {
    await _loadPackagesWithFilters(
      state,
      context.read<PackagesCubit>(),
      page: page,
    );
  }

  Future<void> _onReviewSubmitted() async {
    final cubit = context.read<PackagesCubit>();
    final latestState = cubit.state;
    await _loadPackagesWithFilters(
      latestState,
      cubit,
      page: latestState.currentPage,
    );
  }

  Future<void> _onRetry() async {
    await context.read<PackagesCubit>().retryLastPackagesRequest();
  }
}
