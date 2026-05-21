import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/privacy_section_card.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class TermsOfUseScreenBody extends StatelessWidget {
  const TermsOfUseScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    List<String> lines(String text) =>
        text.split('\n').where((e) => e.trim().isNotEmpty).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            PrivacySectionCard(
              title: loc.termsAcceptanceTitle,
              icon: Icons.check_circle_outline_rounded,
              iconColor: const Color(0xFF008545),
              iconBgColor: const Color(0xFFE6F6EC),
              description: loc.termsAcceptanceDescription,
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.termsUseServicesTitle,
              icon: Icons.gavel_rounded,
              iconColor: const Color(0xFF134FA2),
              iconBgColor: const Color(0xFFE6F0FF),
              description: loc.termsUseServicesDescription,
              bulletPoints: lines(loc.termsUseServicesBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.termsBookingsTitle,
              icon: Icons.error_outline_rounded,
              iconColor: const Color(0xFFD97706),
              iconBgColor: const Color(0xFFFFF9E5),
              description: loc.termsBookingsDescription,
              bulletPoints: lines(loc.termsBookingsBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.termsCancellationTitle,
              icon: Icons.cancel_outlined,
              iconColor: const Color(0xFFD32F2F),
              iconBgColor: const Color(0xFFFFEBEE),
              description: loc.termsCancellationDescription,
              bulletPoints: lines(loc.termsCancellationBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.termsUserContentTitle,
              description: loc.termsUserContentDescription,
              bulletPoints: lines(loc.termsUserContentBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.termsIntellectualTitle,
              description: loc.termsIntellectualDescription,
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.termsEmergencyTitle,
              description: loc.termsEmergencyDescription,
              bulletPoints: lines(loc.termsEmergencyBullets),
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.termsChangesTitle,
              description: loc.termsChangesDescription,
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: loc.termsGoverningTitle,
              description: loc.termsGoverningDescription,
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
