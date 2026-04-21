import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/active_chip.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_option.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/filter_tap.dart';

class ServiceFiltersSection extends StatelessWidget {
  final bool hasActiveFilters;
  final bool showAppliedBudgetChip;
  final String selectedFilter;
  final FilterOptions filterOptions;
  final double minPrice;
  final double maxPrice;
  final List<String> filters;
  final VoidCallback onOpenFilter;
  final VoidCallback onRemoveCategory;
  final VoidCallback onRemovePlace;
  final VoidCallback onRemoveBudget;
  final VoidCallback onRemoveSort;
  final ValueChanged<String> onFilterChanged;

  const ServiceFiltersSection({
    super.key,
    required this.hasActiveFilters,
    required this.showAppliedBudgetChip,
    required this.selectedFilter,
    required this.filterOptions,
    required this.minPrice,
    required this.maxPrice,
    required this.filters,
    required this.onOpenFilter,
    required this.onRemoveCategory,
    required this.onRemovePlace,
    required this.onRemoveBudget,
    required this.onRemoveSort,
    required this.onFilterChanged,
  });

  String _sortLabel() {
    switch (filterOptions.sort.apiValue) {
      case 'price_asc':
        return 'Price: Low to High';
      case 'price_desc':
        return 'Price: High to Low';
      case 'alphabetical':
        return 'Alphabetical';
      default:
        return 'Newest';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onOpenFilter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: hasActiveFilters
                  ? const Color(0xffdb6000)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.tune_rounded,
                  size: 18.sp,
                  color: hasActiveFilters ? Colors.white : Colors.black87,
                ),
                SizedBox(width: 8.w),
                AppText(
                  'Filter',
                  style: font14w700.copyWith(
                    color: hasActiveFilters ? Colors.white : Colors.black87,
                  ),
                ),
                if (hasActiveFilters) ...[
                  SizedBox(width: 6.w),
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        if (hasActiveFilters) ...[
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              children: [
                if (selectedFilter != 'All')
                  ActiveChip(
                    label: selectedFilter,
                    icon: Icons.category_outlined,
                    onRemove: onRemoveCategory,
                  ),
                if (filterOptions.selectedCity != null)
                  ActiveChip(
                    label: filterOptions.selectedCity!,
                    icon: Icons.location_on_outlined,
                    onRemove: onRemovePlace,
                  ),
                if (showAppliedBudgetChip ||
                    filterOptions.budgetRange.start > minPrice ||
                    filterOptions.budgetRange.end < maxPrice)
                  ActiveChip(
                    label:
                        '\$${filterOptions.budgetRange.start.toInt()} – \$${filterOptions.budgetRange.end.toInt()}',
                    icon: Icons.attach_money,
                    onRemove: onRemoveBudget,
                  ),
                if (filterOptions.sort.apiValue != 'newest')
                  ActiveChip(
                    label: _sortLabel(),
                    icon: Icons.sort,
                    onRemove: onRemoveSort,
                  ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],
        FilterTabs(
          selectedFilter: selectedFilter,
          filters: filters,
          onFilterChanged: onFilterChanged,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
