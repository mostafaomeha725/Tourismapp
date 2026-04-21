import 'package:flutter/material.dart';
import 'package:tourismapp/features/service/domain/usecases/get_packages_usecase.dart';

class FilterOptions {
  final String? selectedCity;
  final RangeValues budgetRange;
  final PackagesSortOption sort;

  const FilterOptions({
    this.selectedCity,
    required this.budgetRange,
    this.sort = PackagesSortOption.newest,
  });

  FilterOptions copyWith({
    String? selectedCity,
    bool clearCity = false,
    RangeValues? budgetRange,
    PackagesSortOption? sort,
  }) {
    return FilterOptions(
      selectedCity: clearCity ? null : (selectedCity ?? this.selectedCity),
      budgetRange: budgetRange ?? this.budgetRange,
      sort: sort ?? this.sort,
    );
  }
}
