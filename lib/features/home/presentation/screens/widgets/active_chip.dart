import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onRemove;

  const ActiveChip({
    super.key,
    required this.label,
    required this.icon,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: const Color(0xffdb6000).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        // ignore: deprecated_member_use
        border: Border.all(color: const Color(0xffdb6000).withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: const Color(0xffdb6000)),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xffdb6000),
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 14.sp,
              color: const Color(0xffdb6000),
            ),
          ),
        ],
      ),
    );
  }
}
