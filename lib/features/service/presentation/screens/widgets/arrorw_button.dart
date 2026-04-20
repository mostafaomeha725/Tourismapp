import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrowNavButton extends StatelessWidget {
  final IconData icon;
  final bool isEnabled;
  final VoidCallback onTap;

  const ArrowNavButton({
    super.key,
    required this.icon,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: isEnabled ? 1 : 0.6,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          borderRadius: BorderRadius.circular(14.r),
          child: Ink(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: isEnabled
                  ? const Color(0xFFF8FAFC)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isEnabled
                    ? const Color(0xFFD8E1EC)
                    : const Color(0xFFE5EBF3),
                width: 1.2,
              ),
            ),
            child: Icon(
              icon,
              color: isEnabled
                  ? const Color(0xFF334155)
                  : const Color(0xFF94A3B8),
              size: 22.sp,
            ),
          ),
        ),
      ),
    );
  }
}
