import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/bouncing_widgets.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/service/domain/usecases/get_packages_usecase.dart';

class ServiceSortSection extends StatelessWidget {
  final PackagesSortOption selectedSort;
  final ValueChanged<PackagesSortOption> onSortChanged;

  const ServiceSortSection({
    super.key,
    required this.selectedSort,
    required this.onSortChanged,
  });

  static const List<PackagesSortOption> _options = [
    PackagesSortOption.newest,
    PackagesSortOption.priceAsc,
    PackagesSortOption.priceDesc,
    PackagesSortOption.alphabetical,
  ];

  String _label(PackagesSortOption option) {
    switch (option) {
      case PackagesSortOption.newest:
        return 'Newest';
      case PackagesSortOption.priceAsc:
        return 'Price: Low to High';
      case PackagesSortOption.priceDesc:
        return 'Price: High to Low';
      case PackagesSortOption.alphabetical:
        return 'Alphabetical';
    }
  }

  IconData _icon(PackagesSortOption option) {
    switch (option) {
      case PackagesSortOption.newest:
        return Icons.schedule_rounded;
      case PackagesSortOption.priceAsc:
        return Icons.arrow_upward_rounded;
      case PackagesSortOption.priceDesc:
        return Icons.arrow_downward_rounded;
      case PackagesSortOption.alphabetical:
        return Icons.sort_by_alpha_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Sort by',
            style: font14w700.copyWith(color: const Color(0xFF222222)),
          ),
          SizedBox(height: 10.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _options.map((option) {
                final bool isSelected = option == selectedSort;
                return Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.w),
                  child: BounceIt(
                    onPressed: () {
                      if (isSelected) {
                        return;
                      }
                      onSortChanged(option);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xffdb6000)
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(22.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xffdb6000)
                              : const Color(0xFFE6EBF2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _icon(option),
                            size: 15.sp,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                          SizedBox(width: 6.w),
                          AppText(
                            _label(option),
                            style: font12w700.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
