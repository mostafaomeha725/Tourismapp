import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_divider.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_list_title.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/section_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(radius: 28.r, backgroundColor: Colors.grey),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText("Mostafa Hussein", style: font16w600),
                      AppText("mostafa.hussein@gmail.com", style: font10w400),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).push(Routes.editProfileScreen);
                    },
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

                    CustomListTile(
                      icon: Icons.calendar_month,
                      title: "Bookings",
                      onTap: () {
                        GoRouter.of(context).push(Routes.bookingsListScreen);
                      },
                    ),
                    SizedBox(height: 6.h),
                    CustomDivider(),

                    SizedBox(height: 12.h),
                    CustomListTile(
                      icon: Icons.location_on_outlined,
                      title: "Visited Places",
                      onTap: () {
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
