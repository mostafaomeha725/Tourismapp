import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

void showEmergencySheet(BuildContext context) {
  int counter = 5;
  Timer? timer;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          void startTimer() {
            timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
              if (counter > 0) {
                counter--;
                setState(() {});
              }

              if (counter == 0) {
                timer?.cancel();
                GoRouter.of(context).pop();
                _callTourismPolice();
              }
            });
          }

          if (timer == null) startTimer();

          return Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
              padding: EdgeInsets.all(20.w),
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        "Emergency - Tourism Police",
                        style: font18w700.copyWith(
                          color: Colors.red,
                          fontSize: 18.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          timer?.cancel();
                          GoRouter.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 26.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  AppText(
                    "A call will be made to Tourism Police in $counter seconds",
                    style: font14w400.copyWith(fontSize: 14.sp),
                    overflow: TextOverflow.visible,
                  ),

                  SizedBox(height: 15.h),

                  /// Counter
                  AppText(
                    "$counter",
                    style: font50w700.copyWith(
                      color: Colors.red,
                      fontSize: 50.sp,
                    ),
                    alignment: AlignmentDirectional.center,
                  ),

                  SizedBox(height: 8.h),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      value: (5 - counter) / 5,
                      minHeight: 8.h,
                      backgroundColor: Colors.grey.shade200,
                      color: Colors.red,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: Colors.red, size: 20.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: AppText(
                            "Tourism Police Number: 126\nAvailable 24 hours for tourist emergency assistance",
                            style: font14w500.copyWith(fontSize: 14.sp),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    width: double.infinity,
                    child: AppButton.icon(
                      text: 'Call Now',
                      onPressed: () {
                        timer?.cancel();
                        GoRouter.of(context).pop();
                        _callTourismPolice();
                      },
                      height: 42.h,
                      color: Colors.red,
                      textSize: 14.sp,
                      textWeight: FontWeight.w500,
                      child: Icon(Icons.call, color: Colors.white, size: 18.sp),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  SizedBox(
                    width: double.infinity,
                    child: AppButton.icon(
                      text: 'Cancel',
                      onPressed: () {
                        timer?.cancel();
                        GoRouter.of(context).pop();
                      },
                      height: 42.h,
                      textColor: Colors.black,
                      borderColor: Colors.grey,
                      color: Colors.white,
                      textSize: 14.sp,
                      textWeight: FontWeight.w500,
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> _callTourismPolice() async {
  final Uri url = Uri(scheme: 'tel', path: '126');
  await launchUrl(url);
}
