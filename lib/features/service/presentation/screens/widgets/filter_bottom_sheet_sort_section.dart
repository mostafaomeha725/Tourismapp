import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/bouncing_widgets.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/service/domain/usecases/get_packages_usecase.dart';

class FilterBottomSheetSortSection extends StatelessWidget {
  final PackagesSortOption selectedSort;
  final ValueChanged<PackagesSortOption> onSortSelected;

  const FilterBottomSheetSortSection({
    super.key,
    required this.selectedSort,
    required this.onSortSelected,
  });

  static const List<PackagesSortOption> _sortOptions = [
    PackagesSortOption.newest,
    PackagesSortOption.priceAsc,
    PackagesSortOption.priceDesc,
    PackagesSortOption.alphabetical,
  ];

  String _labelForSort(PackagesSortOption sortOption) {
    switch (sortOption) {
      case PackagesSortOption.priceAsc:
        return 'Price: Low to High';
      case PackagesSortOption.priceDesc:
        return 'Price: High to Low';
      case PackagesSortOption.alphabetical:
        return 'Alphabetical';
      case PackagesSortOption.newest:
        return 'Newest';
    }
  }

  IconData _iconForSort(PackagesSortOption sortOption) {
    switch (sortOption) {
      case PackagesSortOption.priceAsc:
        return Icons.south;
      case PackagesSortOption.priceDesc:
        return Icons.north;
      case PackagesSortOption.alphabetical:
        return Icons.sort_by_alpha;
      case PackagesSortOption.newest:
        return Icons.access_time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Sort by', style: font16w700),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _sortOptions.map((sortOption) {
            final isSelected = selectedSort == sortOption;
            return BounceIt(
              onPressed: () {
                onSortSelected(sortOption);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xffdb6000)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xffdb6000)
                        : Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _iconForSort(sortOption),
                      size: 16.sp,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      _labelForSort(sortOption),
                      style: font12w700.copyWith(
                        color: isSelected ? Colors.white : Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
