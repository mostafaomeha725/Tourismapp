import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/app_image.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class VisitedPlaceCard extends StatelessWidget {
  const VisitedPlaceCard({
    super.key,
    required this.title,
    required this.image,
    required this.date,
    this.rating = 5.0,
  });

  final String title;
  final String image;
  final String date;
  final double rating;

  @override
  Widget build(BuildContext context) {
    final filledStars = rating.clamp(0, 5).round();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1.w),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
            spreadRadius: 0,
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: image.startsWith('http')
                    ? AppImage(imageUrl: image, fit: BoxFit.cover)
                    : AppAsset(assetName: image, fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: font16w700,
                    ),
                    SizedBox(height: 6.h),
                    AppText(
                      date,
                      style: font12w500.copyWith(color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star_rounded,
                          color: index < filledStars
                              ? const Color(0xFFFFC107)
                              : Colors.grey.shade300,
                          size: 18.sp,
                        );
                      }),
                    ),
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
