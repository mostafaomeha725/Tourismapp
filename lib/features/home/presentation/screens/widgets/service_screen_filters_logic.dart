part of '../service_screen.dart';

extension _ServiceScreenFiltersLogic on _ServiceScreenState {
  bool _hasActiveFilters(double minPrice, double maxPrice) {
    return _filterOptions.selectedCity != null ||
        _selectedFilter != 'All' ||
        _isBudgetFilterActive(minPrice, maxPrice) ||
        _isBudgetApplied;
  }

  Future<void> _loadPackagesWithFilters(
    PackagesState state,
    PackagesCubit cubit, {
    int page = 1,
  }) async {
    final hasBudgetFilter = _isBudgetFilterActive(
      state.minPrice,
      state.maxPrice,
    );
    final effectiveMinPrice = hasBudgetFilter
        ? _filterOptions.budgetRange.start
        : state.minPrice;
    final effectiveMaxPrice = hasBudgetFilter
        ? _filterOptions.budgetRange.end
        : state.maxPrice;

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
      minPrice: effectiveMinPrice,
      maxPrice: effectiveMaxPrice,
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
            _withStateUpdate(() {
              _filterOptions = options;
              _isBudgetApplied = true;
            });
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
}
