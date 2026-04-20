import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/core/widgets/rating_stars.dart';

class ReviewSummaryCard extends StatelessWidget {
  final double averageRating;
  final int reviewsCount;

  const ReviewSummaryCard({
    super.key,
    required this.averageRating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8ED),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFFE4BF)),
      ),
      child: Row(
        children: [
          AppText(
            averageRating.toStringAsFixed(1),
            style: font20w700.copyWith(color: const Color(0xFFE87306)),
          ),
          SizedBox(width: 10.w),
          RatingStars(
            rating: averageRating,
            size: 15,
            spacing: 2,
            activeColor: const Color(0xFFFFC107),
            inactiveColor: Colors.grey,
          ),
          const Spacer(),
          AppText(
            '$reviewsCount reviews',
            style: font12w500.copyWith(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
