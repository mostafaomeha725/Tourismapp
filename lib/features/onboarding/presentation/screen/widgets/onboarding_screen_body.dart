import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class OnboardingScreenBody extends StatelessWidget {
  const OnboardingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        children: [
          SizedBox(height: 32.h),
          AppAsset(
            assetName: Assets.egyptsplash,

            borderRadius: BorderRadius.circular(12.r),
          ),
          SizedBox(height: 32.h),

          AppText(
            loc.discoverEgypt,
            style: font32w700,
            alignment: AlignmentDirectional.center,
          ),
          SizedBox(height: 12.h),
          AppText(
            loc.exploreDestinations,
            alignment: AlignmentDirectional.center,
            style: font16w400,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),

          Spacer(),
          AppButton(
            text: loc.letsGetStarted,
            onPressed: () {
              GoRouter.of(context).pushReplacement(Routes.authScreen);
            },
            color: Color(0xffdb6000),
            height: 50.h,
            radius: 22.r,
          ),
          SizedBox(height: 62.h),
        ],
      ),
    );
  }
}
