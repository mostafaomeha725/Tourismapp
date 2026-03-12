import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 66.h),

          AppAsset(assetName: Assets.logo, height: 180.h),
          SizedBox(height: 4.h),

          AppText(
            'Let’s get started!',
            style: font20w700,
            alignment: AlignmentDirectional.center,
          ),
          Spacer(),
          AppText(
            'Start your travel journey with exclusive tips, guides, and offers.',
            style: font16w400,
            alignment: AlignmentDirectional.center,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
          Spacer(),
          AppButton(
            text: 'Login',
            color: Color(0xffdb6000),
            onPressed: () {
              GoRouter.of(context).push(Routes.loginScreen);
            },
            height: 52.h,
            radius: 22.r,
          ),
          SizedBox(height: 12.h),

          AppButton(
            text: 'Sign Up',
            textColor: Color(0xffdb6000),
            borderColor: Color(0xffdb6000),
            color: Colors.white,
            onPressed: () {
              GoRouter.of(context).push(Routes.registerScreen);
            },
            height: 52.h,
            radius: 22.r,
          ),
          SizedBox(height: 68.h),
        ],
      ),
    );
  }
}
