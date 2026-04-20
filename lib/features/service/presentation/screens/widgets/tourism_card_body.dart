import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/tourism_card_location_actions.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/tourism_card_service_actions.dart';

class TourismCardBody extends StatelessWidget {
  final String title;
  final String description;
  final bool isicon;
  final bool hasLocation;
  final String normalizedLocation;
  final bool showMapButton;
  final VoidCallback onViewMap;
  final Future<void> Function() onEvaluate;
  final VoidCallback? onBook;
  final double? price;
  final double? rating;
  final int? reviewsCount;

  const TourismCardBody({
    super.key,
    required this.title,
    required this.description,
    required this.isicon,
    required this.hasLocation,
    required this.normalizedLocation,
    required this.showMapButton,
    required this.onViewMap,
    required this.onEvaluate,
    required this.onBook,
    required this.price,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, style: font16w700),
          SizedBox(height: 8.h),
          AppText(
            description,
            overflow: TextOverflow.visible,
            style: font12w400.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: 32.h),
          isicon
              ? TourismCardServiceActions(
                  price: price,
                  rating: rating,
                  reviewsCount: reviewsCount,
                  onEvaluate: onEvaluate,
                  onBook: onBook,
                )
              : TourismCardLocationActions(
                  hasLocation: hasLocation,
                  normalizedLocation: normalizedLocation,
                  showMapButton: showMapButton,
                  onViewMap: onViewMap,
                ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
