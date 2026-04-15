import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class TourismCardLocationActions extends StatelessWidget {
  final bool hasLocation;
  final String normalizedLocation;
  final bool showMapButton;
  final VoidCallback onViewMap;

  const TourismCardLocationActions({
    super.key,
    required this.hasLocation,
    required this.normalizedLocation,
    required this.showMapButton,
    required this.onViewMap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hasLocation) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(normalizedLocation, style: font12w700),
              Icon(
                Icons.location_on_outlined,
                size: 18.sp,
                color: Colors.orange,
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
        if (showMapButton)
          AppButton(
            text: 'View on map',
            textSize: 16.sp,
            color: const Color(0xffdb6000),
            onPressed: onViewMap,
            height: 50.h,
            radius: 22.r,
          ),
      ],
    );
  }
}
