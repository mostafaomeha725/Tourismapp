import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/presentation/screens/rate_service_dialog.dart';

class TourismCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String location;
  final VoidCallback onViewMap;
  final String text;
  final IconData? icon;
  final bool isicon;
  final void Function()? onBook;
  final double? price;

  const TourismCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.location,
    required this.onViewMap,
    required this.text,
    this.icon,
    this.isicon = false,
    this.onBook,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: AppAsset(
                    assetName: imageUrl,
                    width: double.infinity,
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
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
                      children: [
                        AppText(
                          text,
                          style: font12w700.copyWith(color: Colors.white),
                        ),
                        SizedBox(width: 4.w),
                        if (isicon)
                          Icon(icon, size: 16.sp, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
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
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        AppText(
                          location,
                          style: font12w700.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
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
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  price != null ? "\$${price!.toInt()}" : "—",
                                  style: font18w700.copyWith(
                                    color: Colors.orange,
                                  ),
                                ),

                                Row(
                                  children: [
                                    AppText(
                                      "(124)",
                                      style: font12w400.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    SizedBox(width: 4),

                                    AppText("4.8", style: font16w600),

                                    SizedBox(width: 3),

                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 20.sp,
                                    ),
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

                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const RateServiceDialog(),
                                      );
                                    },
                                    height: 42.h,
                                    borderColor: Colors.grey,
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    textSize: 14.sp,
                                    textWeight: FontWeight.w500,
                                    child: Icon(
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
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(location, style: font12w700),

                                Icon(
                                  Icons.location_on_outlined,
                                  size: 18.sp,
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            AppButton(
                              text: 'View on map',
                              textSize: 16.sp,
                              color: Color(0xffdb6000),
                              onPressed: onViewMap,

                              height: 50.h,
                              radius: 22.r,
                            ),
                          ],
                        ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
