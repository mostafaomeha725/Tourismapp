import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class FilterBottomSheetHeader extends StatelessWidget {
  final VoidCallback onReset;

  const FilterBottomSheetHeader({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              onTap: onReset,
              child: AppText(
                'Reset all',
                style: font14w500.copyWith(color: const Color(0xffdb6000)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
