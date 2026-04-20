import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class HelperChatHeader extends StatelessWidget {
  const HelperChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      margin: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          AppAsset(assetName: Assets.chatbot, width: 32.w, height: 32.h),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('Tourist Assistant', style: font18w700),
              SizedBox(height: 3.h),
              AppText(
                'Ask me about tourism in Egypt',
                style: font12w400.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Color(0xff2DBE60),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              AppText(
                'Online',
                style: font12w500.copyWith(color: const Color(0xff2DBE60)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
