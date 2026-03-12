import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/core/theme/styles.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLocationTap;

  const HomeAppbar({
    super.key,
    required this.title,
    this.subtitle,
    this.onMenuTap,
    this.onLocationTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(80.h);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              GestureDetector(
                onTap: onMenuTap,
                child: Container(
                  width: 38.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.menu, color: Colors.black, size: 22.sp),
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(title, style: font18w700),
                      SizedBox(height: 2.h),
                      AppText(
                        subtitle ?? "Discover Egypt",
                        style: font12w400.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),

                  SizedBox(width: 12.w),

                  GestureDetector(
                    onTap: onLocationTap,
                    child: Container(
                      width: 38.w,
                      height: 38.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF8C00),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
