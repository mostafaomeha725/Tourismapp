import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/app_image.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/core/widgets/rating_stars.dart';

class VisitedPlaceCard extends StatelessWidget {
  const VisitedPlaceCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    this.rating = 5.0,
  });

  final String title;
  final String description;
  final String image;
  final double price;
  final double rating;

  @override
  Widget build(BuildContext context) {
    final normalizedRating = rating.clamp(0, 5).toDouble();

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: font16w700,
                    ),
                    SizedBox(height: 6.h),
                    AppText(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: font12w500.copyWith(color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        RatingStars(
                          rating: normalizedRating,
                          size: 16,
                          spacing: 1,
                          activeColor: const Color(0xFFFFC107),
                          inactiveColor: Colors.grey,
                        ),

                        const Spacer(),
                        AppText(
                          '\$${price.toStringAsFixed(0)}',
                          style: font14w700.copyWith(
                            color: const Color(0xffdb6000),
                          ),
                        ),
                      ],
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
