import 'package:flutter/material.dart';

class FilterOptions {
  final String? selectedCity;
  final RangeValues budgetRange;

  const FilterOptions({this.selectedCity, required this.budgetRange});

  FilterOptions copyWith({
    String? selectedCity,
    bool clearCity = false,
    RangeValues? budgetRange,
  }) {
    return FilterOptions(
      selectedCity: clearCity ? null : (selectedCity ?? this.selectedCity),
      budgetRange: budgetRange ?? this.budgetRange,
    );
  }
}
