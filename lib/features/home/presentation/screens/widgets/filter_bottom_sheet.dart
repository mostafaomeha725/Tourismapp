import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/filter_option.dart';

class FilterBottomSheet extends StatefulWidget {
  final FilterOptions initialOptions;
  final ValueChanged<FilterOptions> onApply;
  final List<Map<String, dynamic>> places;
  final double minBudget;
  final double maxBudget;

  const FilterBottomSheet({
    super.key,
    required this.initialOptions,
    required this.onApply,
    required this.places,
    required this.minBudget,
    required this.maxBudget,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String? _selectedCity;
  late RangeValues _budgetRange;

  late double _minBudget;
  late double _maxBudget;

  @override
  void initState() {
    super.initState();
    _minBudget = widget.minBudget;
    _maxBudget = widget.maxBudget <= widget.minBudget
        ? widget.minBudget + 1
        : widget.maxBudget;
    _selectedCity = widget.initialOptions.selectedCity;
    final start = widget.initialOptions.budgetRange.start.clamp(
      _minBudget,
      _maxBudget,
    );
    final end = widget.initialOptions.budgetRange.end.clamp(
      _minBudget,
      _maxBudget,
    );
    _budgetRange = RangeValues(
      start.toDouble(),
      end.toDouble() < start.toDouble() ? start.toDouble() : end.toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText('Filter', style: font20w700),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCity = null;
                    _budgetRange = RangeValues(_minBudget, _maxBudget);
                  });
                },
                child: AppText(
                  'Reset all',
                  style: font14w500.copyWith(color: const Color(0xffdb6000)),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          AppText('Location', style: font16w700),
          SizedBox(height: 12.h),

          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: widget.places.map((city) {
              final bool isSelected = _selectedCity == city['name'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCity = isSelected ? null : city['name'] as String;
                  });
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

          SizedBox(height: 28.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText('Budget', style: font16w700),
              AppText(
                '\$${_budgetRange.start.toInt()}  –  \$${_budgetRange.end.toInt()}',
                style: font14w500.copyWith(color: const Color(0xffdb6000)),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xffdb6000),
              inactiveTrackColor: const Color(0xFFEEF2F6),
              thumbColor: const Color(0xffdb6000),
              overlayColor: const Color(0xffdb6000).withOpacity(0.15),
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 10,
              ),
              trackHeight: 4.h,
            ),
            child: RangeSlider(
              values: _budgetRange,
              min: _minBudget,
              max: _maxBudget,
              divisions: (_maxBudget - _minBudget).toInt().clamp(1, 100),
              onChanged: (values) {
                setState(() {
                  _budgetRange = values;
                });
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                '\$${_minBudget.toInt()}',
                style: font12w400.copyWith(color: Colors.grey),
              ),
              AppText(
                '\$${_maxBudget.toInt()}+',
                style: font12w400.copyWith(color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 28.h),

          AppButton(
            text: 'Apply Filters',
            color: const Color(0xffdb6000),
            height: 52.h,
            radius: 22.r,
            onPressed: () {
              widget.onApply(
                FilterOptions(
                  selectedCity: _selectedCity,
                  budgetRange: _budgetRange,
                ),
              );
              GoRouter.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
