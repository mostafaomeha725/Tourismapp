import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class FilterBottomSheetBudgetSection extends StatelessWidget {
  final RangeValues budgetRange;
  final double minBudget;
  final double maxBudget;
  final ValueChanged<RangeValues> onChanged;

  const FilterBottomSheetBudgetSection({
    super.key,
    required this.budgetRange,
    required this.minBudget,
    required this.maxBudget,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText('Budget', style: font16w700),
            AppText(
              '\$${budgetRange.start.toInt()}  –  \$${budgetRange.end.toInt()}',
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
            values: budgetRange,
            min: minBudget,
            max: maxBudget,
            divisions: (maxBudget - minBudget).toInt().clamp(1, 100),
            onChanged: onChanged,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              '\$${minBudget.toInt()}',
              style: font12w400.copyWith(color: Colors.grey),
            ),
            AppText(
              '\$${maxBudget.toInt()}+',
              style: font12w400.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
