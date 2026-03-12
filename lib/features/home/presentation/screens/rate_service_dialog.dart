import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class RateServiceDialog extends StatefulWidget {
  const RateServiceDialog({super.key});

  @override
  State<RateServiceDialog> createState() => _RateServiceDialogState();
}

class _RateServiceDialogState extends State<RateServiceDialog> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.r,
              offset: Offset(0, 10.h),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        AppText(
                          "Rate Service",
                          style: font20w700,
                          alignment: AlignmentDirectional.center,
                        ),
                        SizedBox(height: 8.h),
                        AppText(
                          "Ahmed Mohamed - Tour Guide",
                          alignment: AlignmentDirectional.center,
                          style: font14w400.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close, color: Colors.grey, size: 24.sp),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              AppText(
                "Choose your rating",
                alignment: AlignmentDirectional.center,
                style: font14w500.copyWith(color: Colors.black54),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    icon: Icon(
                      index < _rating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 40.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  );
                }),
              ),

              SizedBox(height: 20.h),

              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  "Notes (Optional)",
                  style: font14w700.copyWith(color: Colors.grey.shade700),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F8),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextField(
                  maxLines: 3,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: "Share your experience with this service...",
                    hintStyle: font12w400.copyWith(color: Colors.grey.shade400),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15.w),
                  ),
                ),
              ),

              SizedBox(height: 25.h),

              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Submit Review',
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  height: 48.h,
                  color: Colors.orange,
                  textSize: 16.sp,
                  textWeight: FontWeight.bold,
                  textColor: Colors.white,
                ),
              ),

              SizedBox(height: 12.h),

              SizedBox(
                width: double.infinity,
                child: AppButton(
                  text: 'Cancel',
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  height: 48.h,
                  textColor: Colors.black,
                  borderColor: Colors.grey,
                  color: Colors.white,
                  textSize: 16.sp,
                  textWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
