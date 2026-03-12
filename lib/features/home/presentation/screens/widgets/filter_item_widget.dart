import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class FilterItemWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: isSelected ? EdgeInsets.symmetric(vertical: 8.h) : null,
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                )
              : null,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (icon == null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 20.sp),
                SizedBox(height: 4.h),
                FittedBox(child: AppText(title, style: font10w500)),
              ],
            ),
          ),
          FittedBox(
            child: AppText(
              title,
              style: font10w500,
              alignment: AlignmentDirectional.center,
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.black87, size: 20.sp),
        SizedBox(height: 4.h),
        FittedBox(
          child: AppText(
            title,
            style: font10w500,
            alignment: AlignmentDirectional.center,
          ),
        ),
      ],
    );
  }
}
