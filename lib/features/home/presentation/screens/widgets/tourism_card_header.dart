import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/app_image.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class TourismCardHeader extends StatelessWidget {
  final String normalizedImageUrl;
  final String placeholderImageUrl;
  final bool hasValidImage;
  final bool isNetworkImage;
  final String text;
  final bool isicon;
  final IconData? icon;
  final bool hasLocation;
  final String normalizedLocation;

  const TourismCardHeader({
    super.key,
    required this.normalizedImageUrl,
    required this.placeholderImageUrl,
    required this.hasValidImage,
    required this.isNetworkImage,
    required this.text,
    required this.isicon,
    required this.icon,
    required this.hasLocation,
    required this.normalizedLocation,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth - 32.w;
        final double maxBadgeWidth = hasLocation ? totalWidth / 2 : totalWidth;

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: !hasValidImage
                  ? AppImage(
                      imageUrl: placeholderImageUrl,
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.cover,
                    )
                  : isNetworkImage
                  ? AppImage(
                      imageUrl: normalizedImageUrl,
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.cover,
                    )
                  : AppAsset(
                      assetName: normalizedImageUrl,
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxBadgeWidth),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: AppText(
                            text,
                            style: font12w700.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      if (isicon) ...[
                        SizedBox(width: 4.w),
                        Icon(icon, size: 16.sp, color: Colors.white),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (hasLocation)
              Positioned(
                top: 8.h,
                left: 8.w,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxBadgeWidth),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: AppText(
                              normalizedLocation,
                              style: font12w700.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
