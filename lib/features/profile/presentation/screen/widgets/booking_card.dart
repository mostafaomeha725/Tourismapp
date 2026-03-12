import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.title,
    required this.image,
    required this.date,
    required this.price,
    this.status = "confirmed",
    this.onCancelTap,
  });

  final String title;
  final String image;
  final String date;
  final String price;
  final String status;
  final VoidCallback? onCancelTap;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;

    switch (status.toLowerCase()) {
      case 'pending':
        statusColor = const Color(0xFFCfa006);
        statusBgColor = const Color(0xFFFFF9E5);
        statusIcon = Icons.access_time_rounded;
        break;
      case 'completed':
        statusColor = const Color(0xFF134FA2);
        statusBgColor = const Color(0xFFE6F0FF);
        statusIcon = Icons.check_circle_outline;
        break;
      case 'confirmed':
      default:
        statusColor = const Color(0xFF008545);
        statusBgColor = const Color(0xFFE6F6EC);
        statusIcon = Icons.check_circle_outline;
        break;
    }

    bool showCancelButton = status.toLowerCase() != 'completed';

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 4,
      // ignore: deprecated_member_use
      shadowColor: Colors.black.withOpacity(0.1),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 110.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: font16w700.copyWith(fontSize: 16.sp),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: statusBgColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              Icon(statusIcon, size: 14.sp, color: statusColor),
                              SizedBox(width: 4.w),
                              AppText(
                                status,
                                style: font12w700.copyWith(
                                  color: statusColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 6.w),
                        AppText(
                          date,
                          style: font12w500.copyWith(
                            color: Colors.grey,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    AppText(
                      "\$$price",
                      style: font16w600.copyWith(
                        color: const Color(0xffdb6000),
                        fontSize: 16.sp,
                      ),
                    ),
                    if (showCancelButton) ...[
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton.icon(
                          onPressed: onCancelTap ?? () {},
                          text: "Cancel Booking",
                          color: Colors.white,
                          borderColor: const Color(0xFFF75555),
                          textColor: const Color(0xFFF75555),
                          textSize: 13.sp,
                          textWeight: FontWeight.w600,
                          radius: 8.r,
                          height: 38.h,
                          gapLeadingText: 6.w,
                          child: Icon(
                            Icons.close,
                            size: 16.sp,
                            color: const Color(0xFFF75555),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
