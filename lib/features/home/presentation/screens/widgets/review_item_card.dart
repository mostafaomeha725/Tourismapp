import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/core/widgets/rating_stars.dart';
import 'package:tourismapp/features/home/domain/entities/review_entity.dart';

class ReviewItemCard extends StatelessWidget {
  final ReviewEntity review;

  const ReviewItemCard({super.key, required this.review});

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _formatDate(review.createdAt);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34.w,
                height: 34.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E2),
                  borderRadius: BorderRadius.circular(17.r),
                ),
                child: Icon(
                  Icons.person,
                  color: const Color(0xFFE87306),
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AppText(
                  review.clientName.isEmpty ? 'Anonymous' : review.clientName,
                  style: font14w700,
                  maxLines: 1,
                ),
              ),
              RatingStars(
                rating: review.rating.toDouble(),
                size: 15,
                spacing: 2,
                activeColor: const Color(0xFFFFC107),
                inactiveColor: Colors.grey,
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            SizedBox(height: 8.h),
            AppText(
              review.comment,
              style: font14w400.copyWith(color: Colors.black87, height: 1.35),
              overflow: TextOverflow.visible,
            ),
          ],
          if (dateText.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: AppText(
                dateText,
                style: font12w400.copyWith(color: Colors.grey.shade600),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
