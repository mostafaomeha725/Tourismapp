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
              .where((place) {
                final location = (place.location ?? '').trim();
                final displayName = location.isNotEmpty
                    ? location
                    : place.title.trim();
                return displayName == _filterOptions.selectedCity;
              })
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
    final packagesCubit = context.read<PackagesCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BlocBuilder<PackagesCubit, PackagesState>(
          bloc: packagesCubit,
          buildWhen: (previous, current) =>
              previous.places != current.places ||
              previous.status != current.status,
          builder: (context, state) {
            final places = state.places
                .map((place) {
                  final location = (place.location ?? '').trim();
                  final displayName = location.isNotEmpty
                      ? location
                      : place.title.trim();
                  return displayName;
                })
                .where((name) => name.isNotEmpty)
                .toSet()
                .map(
                  (name) => {'name': name, 'icon': Icons.location_on_outlined},
                )
                .toList();

            final isLocationLoading =
                places.isEmpty &&
                (state.status.isLoading || state.status == RequestState.init);

            return FilterBottomSheet(
              initialOptions: _filterOptions,
              places: places,
              isLocationLoading: isLocationLoading,
              minBudget: minPrice,
              maxBudget: maxPrice,
              onApply: (options) async {
                _withStateUpdate(() {
                  _filterOptions = options;
                  _isBudgetApplied = true;
                });
                await _loadPackagesWithFilters(
                  packagesCubit.state,
                  packagesCubit,
                  page: 1,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
