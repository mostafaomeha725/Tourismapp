import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class FilterBottomSheetLocationSection extends StatelessWidget {
  final List<Map<String, dynamic>> places;
  final bool isLoading;
  final String? selectedCity;
  final ValueChanged<String> onCityTap;

  const FilterBottomSheetLocationSection({
    super.key,
    required this.places,
    required this.isLoading,
    required this.selectedCity,
    required this.onCityTap,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(loc.location, style: font16w700),
        SizedBox(height: 12.h),
        if (isLoading)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 8.w),
              AppText(
                loc.loadingLocations,
                style: font12w700.copyWith(color: Colors.grey[700]),
              ),
            ],
          )
        else if (places.isEmpty)
          AppText(
            loc.noLocationsAvailable,
            style: font12w700.copyWith(color: Colors.grey[600]),
          )
        else
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
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
