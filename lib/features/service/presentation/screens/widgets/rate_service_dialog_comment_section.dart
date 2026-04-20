import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class RateServiceDialogCommentSection extends StatelessWidget {
  final TextEditingController controller;

  const RateServiceDialogCommentSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Notes (Optional)',
          style: font14w700.copyWith(color: Colors.grey.shade700),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: controller,
            maxLines: 3,
            style: TextStyle(fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: 'Share your experience with this service...',
              hintStyle: font12w400.copyWith(color: Colors.grey.shade400),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.w),
            ),
          ),
        ),
      ],
    );
  }
}
