import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_info_row.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/privacy_section_card.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class PrivacyPolicyScreenBody extends StatelessWidget {
  const PrivacyPolicyScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    List<String> lines(String text) =>
        text.split('\n').where((e) => e.trim().isNotEmpty).toList();

    return SingleChildScrollView(
      //  physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            PrivacySectionCard(
              title: loc.privacyInfoCollectTitle,
              icon: Icons.storage_rounded,
              iconColor: const Color(0xFF134FA2),
              iconBgColor: const Color(0xFFE6F0FF),
              description: loc.privacyInfoCollectDescription,
              bulletPoints: lines(loc.privacyInfoCollectBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.privacyUseInfoTitle,
              icon: Icons.person_outline_rounded,
              iconColor: const Color(0xFF008545),
              iconBgColor: const Color(0xFFE6F6EC),
              description: loc.privacyUseInfoDescription,
              bulletPoints: lines(loc.privacyUseInfoBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.privacyDataSecurityTitle,
              icon: Icons.lock_outline_rounded,
              iconColor: const Color(0xFF9C27B0),
              iconBgColor: const Color(0xFFFAF0FA),
              description: loc.privacyDataSecurityDescription,
              bulletPoints: lines(loc.privacyDataSecurityBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.privacyInfoSharingTitle,
              icon: Icons.visibility_outlined,
              iconColor: const Color(0xFFD97706),
              iconBgColor: const Color(0xFFFFF9E5),
              description: loc.privacyInfoSharingDescription,
              bulletPoints: lines(loc.privacyInfoSharingBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.privacyCookiesTitle,
              description: loc.privacyCookiesDescription,
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.privacyChildrenTitle,
              description: loc.privacyChildrenDescription,
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.privacyContactTitle,
              description: loc.privacyContactDescription,
              extraContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContactInfoRow(
                    label: loc.emailAddress,
                    value: "privacy@tourismapp.com",
                  ),
                  SizedBox(height: 8.h),
                  ContactInfoRow(label: loc.address, value: "Cairo, Egypt"),
                  SizedBox(height: 8.h),
                  ContactInfoRow(label: loc.phone, value: "+20 123 456 7890"),
                ],
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
