import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_divider.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_list_title.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/language_bottom_sheet.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/section_title.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6.r,
            spreadRadius: 2.r,
            offset: Offset(0, 2.r),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            SectionTitle(title: loc.preference),
            SizedBox(height: 12.h),
            CustomListTile(
              icon: Icons.language,
              title: loc.language,
              onTap: () => LanguageBottomSheet.show(context),
            ),
            SizedBox(height: 6.h),
            const CustomDivider(),
            SizedBox(height: 12.h),
            CustomListTile(
              icon: Icons.location_on_outlined,
              title: loc.favouritePlaces,
              onTap: () {
                if (!AuthService.isLoggedIn) {
                  GoRouter.of(context).push(Routes.authScreen);
                  return;
                }
                GoRouter.of(context).push(Routes.visitedPlacesScreen);
              },
            ),
            SizedBox(height: 6.h),
            const CustomDivider(),
            SizedBox(height: 20.h),
            SectionTitle(title: loc.others),
            SizedBox(height: 12.h),
            CustomListTile(
              icon: Icons.privacy_tip_outlined,
              title: loc.privacyPolicy,
              onTap: () {
                GoRouter.of(context).push(Routes.privacyPolicyScreen);
              },
            ),
            SizedBox(height: 6.h),
            const CustomDivider(),
            SizedBox(height: 12.h),
            CustomListTile(
              icon: Icons.description_outlined,
              title: loc.termsOfUse,
              onTap: () {
                GoRouter.of(context).push(Routes.termsOfUseScreen);
              },
            ),
            SizedBox(height: 6.h),
            const CustomDivider(),
            SizedBox(height: 12.h),
            CustomListTile(
              icon: Icons.logout,
              title: loc.logout,
              onTap: () {
                if (!AuthService.isLoggedIn) {
                  GoRouter.of(context).push(Routes.authScreen);
                  return;
                }
                context.read<LogoutCubit>().logout();
              },
            ),
            SizedBox(height: 6.h),
            const CustomDivider(),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}
