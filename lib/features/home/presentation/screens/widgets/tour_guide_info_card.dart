import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/info_item_card.dart';

class TourGuideInfoCard extends StatelessWidget {
  const TourGuideInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              spreadRadius: 2.r,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'Ahmed Mohamed - Tour Guide',
              style: font18w700.copyWith(color: Colors.black87),
            ),

            SizedBox(height: 8.h),

            Row(
              children: [
                ...List.generate(
                  5,
                  (index) => Icon(
                    Icons.star_rounded,
                    color: const Color(0xFFFFC107),
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                AppText(
                  '(4.8 • 124 reviews)',
                  style: font14w500.copyWith(color: Colors.grey),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$50',
                    style: font28w500.copyWith(color: const Color(0xffdb6000)),
                  ),
                  TextSpan(
                    text: '  per person',
                    style: font14w400.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Divider(color: Colors.grey.shade200, thickness: 1),

            SizedBox(height: 16.h),

            Row(
              children: [
                Expanded(
                  child: InfoItemCard(
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    value: 'Giza, Egypt',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: InfoItemCard(
                    icon: Icons.access_time_rounded,
                    title: 'Duration',
                    value: '4 hours',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
