import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/bouncing_widgets.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class PaginationNumberChip extends StatelessWidget {
  final int pageNum;
  final bool isActive;
  final VoidCallback onTap;

  const PaginationNumberChip({
    super.key,
    required this.pageNum,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: BounceIt(
        onPressed: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: isActive ? 48.w : 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [Color(0xFFFF9D42), Color(0xFFDB6000)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isActive ? null : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isActive ? Colors.transparent : const Color(0xFFE2E8F0),
              width: 1.2,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFFDB6000).withOpacity(0.28),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: AppText(
              '$pageNum',
              style: font14w700.copyWith(
                color: isActive ? Colors.white : const Color(0xFF334155),
              ),
              alignment: AlignmentDirectional.center,
            ),
          ),
        ),
      ),
    );
  }
}
