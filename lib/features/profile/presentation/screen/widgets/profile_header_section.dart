import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/cache/preferences_storage.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/di/services_locator.dart';
import 'package:tourismapp/core/enums/app_enums.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class ProfileHeaderSection extends StatelessWidget {
  final VoidCallback onEditProfile;

  const ProfileHeaderSection({super.key, required this.onEditProfile});

  @override
  Widget build(BuildContext context) {
    final prefs = sl<PreferencesStorage>();
    final loc = AppLocalizations.of(context)!;
    final displayName =
        prefs.getString(key: PreferencesKeys.name)?.trim().isNotEmpty == true
        ? prefs.getString(key: PreferencesKeys.name)!.trim()
        : loc.guestUser;
    final displayEmail =
        prefs.getString(key: PreferencesKeys.email)?.trim().isNotEmpty == true
        ? prefs.getString(key: PreferencesKeys.email)!.trim()
        : loc.noEmail;

    return Container(
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
          const Spacer(),
          IconButton(
            onPressed: onEditProfile,
            icon: const Icon(Icons.edit, color: Color(0xff134FA2)),
          ),
        ],
      ),
    );
  }
}
