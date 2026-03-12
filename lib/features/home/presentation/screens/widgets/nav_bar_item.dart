import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/core/theme/styles.dart';

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: isSelected
              ? Matrix4.translationValues(0, -1.h, 0)
              : Matrix4.identity(),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (isSelected)
                    Container(
                      width: 34.w,
                      height: 34.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffdb6000),
                      ),
                    ),
                  Icon(
                    icon,
                    size: 26.sp,
                    color: isSelected ? Colors.white : const Color(0xFF001F6B),
                  ),
                ],
              ),
              // --- التعديل هنا: تقليل المسافة من 4 إلى 2 ---
              SizedBox(height: 2.h),
              // -----------------------------------------
              FittedBox(
                child: AppText(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  alignment: AlignmentDirectional.center,
                  style: font10w500.copyWith(
                    color: isSelected
                        ? const Color(0xffdb6000)
                        : const Color(0xFF001F6B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
