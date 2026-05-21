import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class EmergencySheetContent extends StatelessWidget {
  final int counter;
  final VoidCallback onClose;
  final VoidCallback onCallNow;

  const EmergencySheetContent({
    super.key,
    required this.counter,
    required this.onClose,
    required this.onCallNow,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
        padding: EdgeInsets.all(20.w),
        width: MediaQuery.of(context).size.width * 0.88,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  AppLocalizations.of(context)!.emergencySheetContent,
                  style: font18w700.copyWith(
                    color: Colors.red,
                    fontSize: 18.sp,
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Icon(Icons.close, color: Colors.red, size: 26.sp),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            AppText(
              AppLocalizations.of(
                context,
              )!.callTourismPoliceInSeconds(counter.toString()),
              style: font14w400.copyWith(fontSize: 14.sp),
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 15.h),
            AppText(
              '$counter',
              style: font50w700.copyWith(color: Colors.red, fontSize: 50.sp),
              alignment: AlignmentDirectional.center,
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: (5 - counter) / 5,
                minHeight: 8.h,
                backgroundColor: Colors.grey.shade200,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.red, size: 20.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: AppText(
                      AppLocalizations.of(context)!.tourismPoliceEmergency,
                      style: font14w500.copyWith(fontSize: 14.sp),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: AppButton.icon(
                text: AppLocalizations.of(context)!.callNow,
                onPressed: onCallNow,
                height: 42.h,
                color: Colors.red,
                textSize: 14.sp,
                textWeight: FontWeight.w500,
                child: Icon(Icons.call, color: Colors.white, size: 18.sp),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              child: AppButton.icon(
                text: AppLocalizations.of(context)!.cancel,
                onPressed: onClose,
                height: 42.h,
                textColor: Colors.black,
                borderColor: Colors.grey,
                color: Colors.white,
                textSize: 14.sp,
                textWeight: FontWeight.w500,
                child: Icon(Icons.close, color: Colors.black, size: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
