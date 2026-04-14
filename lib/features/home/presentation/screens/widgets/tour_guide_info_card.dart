import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/utils/rating_formatter.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/core/widgets/rating_stars.dart';
import 'package:tourismapp/features/home/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/info_item_card.dart';

class TourGuideInfoCard extends StatelessWidget {
  final PackageEntity package;

  const TourGuideInfoCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final hasLocation = package.placeTitle.trim().isNotEmpty;

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
              package.providerName,
              style: font18w700.copyWith(color: Colors.black87),
            ),

            SizedBox(height: 8.h),

            Row(
              children: [
                RatingStars(
                  rating: package.averageRating,
                  size: 20,
                  spacing: 2,
                  allowPartial: true,
                  activeColor: const Color(0xFFFFC107),
                  inactiveColor: const Color(0xFFFFC107),
                ),
                SizedBox(width: 8.w),
                AppText(
                  '(${formatRatingCompact(package.averageRating)} • ${package.reviewsCount} reviews)',
                  style: font14w500.copyWith(color: Colors.grey),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$${package.price.toInt()}',
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

            if (hasLocation) ...[
              Divider(color: Colors.grey.shade200, thickness: 1),
              SizedBox(height: 16.h),
              InfoItemCard(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: package.placeTitle,
                widthFactor: 0.5,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
