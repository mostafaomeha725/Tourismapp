import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tourismapp/core/routes/route_paths.dart';
import 'package:tourismapp/core/services/auth_service.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/profile_header_section.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/profile_menu_section.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

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
    final loc = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            ProfileHeaderSection(onEditProfile: _openEditProfile),
            SizedBox(height: 20.h),
            AppText(loc.personalInformation, style: font16w600),
            SizedBox(height: 12.h),
            const ProfileMenuSection(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
