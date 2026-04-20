import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/core/theme/styles.dart';

class TourismCardServiceActions extends StatelessWidget {
  final double? price;
  final double? rating;
  final int? reviewsCount;
  final Future<void> Function() onEvaluate;
  final VoidCallback? onBook;

  const TourismCardServiceActions({
    super.key,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.onEvaluate,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              price != null ? "\$${price!.toInt()}" : "—",
              style: font18w700.copyWith(color: Colors.orange),
            ),
            Row(
              children: [
                AppText(
                  "(${reviewsCount ?? 0})",
                  style: font12w400.copyWith(color: Colors.grey),
                ),
                const SizedBox(width: 4),
                AppText((rating ?? 0).toStringAsFixed(1), style: font16w600),
                const SizedBox(width: 3),
                Icon(Icons.star, color: Colors.orange, size: 20.sp),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: AppButton.icon(
                text: 'evaluate',
                onPressed: () async {
                  await onEvaluate();
                },
                height: 42.h,
                borderColor: Colors.grey,
                color: Colors.white,
                textColor: Colors.black,
                textSize: 14.sp,
                textWeight: FontWeight.w500,
                child: const Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 10,
              child: AppButton(
                text: 'book',
                onPressed: onBook,
                height: 42.h,
                color: Colors.orange,
                textColor: Colors.white,
                textSize: 16.sp,
                textWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
