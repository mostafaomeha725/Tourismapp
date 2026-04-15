import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class FilterBottomSheetLocationSection extends StatelessWidget {
  final List<Map<String, dynamic>> places;
  final String? selectedCity;
  final ValueChanged<String> onCityTap;

  const FilterBottomSheetLocationSection({
    super.key,
    required this.places,
    required this.selectedCity,
    required this.onCityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Location', style: font16w700),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: places.map((city) {
            final bool isSelected = selectedCity == city['name'];
            return GestureDetector(
              onTap: () {
                onCityTap(city['name'] as String);
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
                      city['icon'] as IconData,
                      size: 16.sp,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      city['name'] as String,
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
