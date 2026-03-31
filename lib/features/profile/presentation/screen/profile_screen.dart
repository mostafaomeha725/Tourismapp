import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/enums/app_enums.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_divider.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_list_title.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/section_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _openEditProfile() async {
    if (!AuthService.isLoggedIn) {
      GoRouter.of(context).push(Routes.authScreen);
      return;
    }

    await GoRouter.of(context).push(Routes.editProfileScreen);
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final prefs = sl<PreferencesStorage>();
    final displayName =
        prefs.getString(key: PreferencesKeys.name)?.trim().isNotEmpty == true
        ? prefs.getString(key: PreferencesKeys.name)!.trim()
        : 'Guest User';
    final displayEmail =
        prefs.getString(key: PreferencesKeys.email)?.trim().isNotEmpty == true
        ? prefs.getString(key: PreferencesKeys.email)!.trim()
        : 'No email';

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.all(16.w),
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
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundImage: const AssetImage(Assets.avatar),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(displayName, style: font16w600),
                      AppText(displayEmail, style: font10w400),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: _openEditProfile,
                    icon: Icon(Icons.edit, color: Color(0xff134FA2)),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            AppText("Personal Information", style: font16w600),
            SizedBox(height: 12.h),

            Container(
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

                    SectionTitle(title: "Preference"),
                    SizedBox(height: 12.h),

                    // CustomListTile(
                    //   icon: Icons.calendar_month,
                    //   title: "Bookings",
                    //   onTap: () {
                    //     GoRouter.of(context).push(Routes.bookingsListScreen);
                    //   },
                    // ),
                    // SizedBox(height: 6.h),
                    // CustomDivider(),

                    // SizedBox(height: 12.h),
                    CustomListTile(
                      icon: Icons.location_on_outlined,
                      title: "Favourite Places",
                      onTap: () {
                        if (!AuthService.isLoggedIn) {
                          GoRouter.of(context).push(Routes.authScreen);
                          return;
                        }
                        GoRouter.of(context).push(Routes.visitedPlacesScreen);
                      },
                    ),
                    SizedBox(height: 6.h),
                    CustomDivider(),

                    SizedBox(height: 20.h),

                    SectionTitle(title: "Others"),
                    SizedBox(height: 12.h),

                    CustomListTile(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy Policy",
                      onTap: () {
                        GoRouter.of(context).push(Routes.privacyPolicyScreen);
                      },
                    ),
                    SizedBox(height: 6.h),
                    CustomDivider(),

                    SizedBox(height: 12.h),
                    CustomListTile(
                      icon: Icons.description_outlined,
                      title: "Terms of Use",
                      onTap: () {
                        GoRouter.of(context).push(Routes.termsOfUseScreen);
                      },
                    ),
                    SizedBox(height: 6.h),
                    CustomDivider(),

                    SizedBox(height: 12.h),
                    CustomListTile(
                      icon: Icons.logout,
                      title: "Log out",
                      onTap: () {
                        if (!AuthService.isLoggedIn) {
                          GoRouter.of(context).push(Routes.authScreen);
                          return;
                        }
                        context.read<LogoutCubit>().logout();
                      },
                    ),
                    SizedBox(height: 6.h),
                    CustomDivider(),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
