import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class IncludedItemRow extends StatelessWidget {
  final String text;

  const IncludedItemRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE8F5E9),
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: const Color(0xFF4CAF50),
              size: 20.sp,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: AppText(
              text,
              style: font14w500.copyWith(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
