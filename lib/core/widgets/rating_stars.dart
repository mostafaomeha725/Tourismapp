import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int maxStars;
  final double size;
  final double spacing;
  final bool allowPartial;
  final Color activeColor;
  final Color inactiveColor;

  const RatingStars({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.size = 16,
    this.spacing = 2,
    this.allowPartial = false,
    this.activeColor = const Color(0xFFFFC107),
    this.inactiveColor = const Color(0xFFE2E8F0),
  });

  @override
  Widget build(BuildContext context) {
    final clamped = rating.clamp(0, maxStars).toDouble();

    return Row(
      children: List.generate(maxStars, (index) {
        final fill = allowPartial
            ? (clamped - index).clamp(0.0, 1.0)
            : (index < clamped.round() ? 1.0 : 0.0);

        return Padding(
          padding: EdgeInsets.only(
            right: index == maxStars - 1 ? 0 : spacing.w,
          ),
          child: Stack(
            children: [
              Icon(
                Icons.star_border_rounded,
                color: inactiveColor,
                size: size.sp,
              ),
              if (fill > 0)
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: fill,
                    child: Icon(
                      Icons.star_rounded,
                      color: activeColor,
                      size: size.sp,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
