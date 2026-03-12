import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tourismapp/features/profile/presentation/screen/widgets/custom_info_row.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/privacy_section_card.dart';

class PrivacyPolicyScreenBody extends StatelessWidget {
  const PrivacyPolicyScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //  physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            PrivacySectionCard(
              title: "Information We Collect",
              icon: Icons.storage_rounded,
              iconColor: const Color(0xFF134FA2),
              iconBgColor: const Color(0xFFE6F0FF),
              description:
                  "We collect information that you provide directly to us when using the Tourism App, including:",
              bulletPoints: const [
                "Personal information (name, email address, phone number)",
                "Location data to provide relevant tourist recommendations",
                "Booking history and preferences",
                "Payment information (processed securely through third-party providers)",
                "Photos and reviews you share about your experiences",
              ],
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: "How We Use Your Information",
              icon: Icons.person_outline_rounded,
              iconColor: const Color(0xFF008545),
              iconBgColor: const Color(0xFFE6F6EC),
              description:
                  "Your information helps us provide and improve our services:",
              bulletPoints: const [
                "Process bookings and payments for tours, guides, and services",
                "Send booking confirmations and important updates",
                "Provide personalized recommendations based on your preferences",
                "Improve our services and develop new features",
                "Communicate with you about promotions and special offers",
                "Ensure safety through our emergency contact features",
              ],
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: "Data Security",
              icon: Icons.lock_outline_rounded,
              iconColor: const Color(0xFF9C27B0),
              iconBgColor: const Color(0xFFFAF0FA),
              description:
                  "We take the security of your personal information seriously:",
              bulletPoints: const [
                "All data is encrypted using industry-standard SSL/TLS protocols",
                "Payment information is processed through PCI-compliant providers",
                "Access to personal data is restricted to authorized personnel only",
                "Regular security audits and updates to protect against threats",
                "Secure backup systems to prevent data loss",
              ],
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: "Information Sharing",
              icon: Icons.visibility_outlined,
              iconColor: const Color(0xFFD97706),
              iconBgColor: const Color(0xFFFFF9E5),
              description:
                  "We do not sell your personal information. We may share data with:",
              bulletPoints: const [
                "Service providers (tour guides, photographers) to fulfill your bookings",
                "Payment processors to complete transactions securely",
                "Law enforcement when required by law or to protect safety",
                "Analytics partners to improve our services (anonymized data only)",
              ],
            ),
            SizedBox(height: 20.h),

            const PrivacySectionCard(
              title: "Cookies and Tracking",
              description:
                  "We use cookies and similar technologies to enhance your experience, analyze usage patterns, and remember your preferences. You can control cookie settings through your browser.",
            ),
            SizedBox(height: 20.h),

            const PrivacySectionCard(
              title: "Children's Privacy",
              description:
                  "Our services are not intended for children under 13. We do not knowingly collect personal information from children. If you believe we have collected information from a child, please contact us immediately.",
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: "Contact Us",
              description:
                  "If you have questions about this Privacy Policy or wish to exercise your rights, please contact us:",
              extraContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContactInfoRow(
                    label: "Email",
                    value: "privacy@tourismapp.com",
                  ),
                  SizedBox(height: 8.h),
                  ContactInfoRow(label: "Address", value: "Cairo, Egypt"),
                  SizedBox(height: 8.h),
                  ContactInfoRow(label: "Phone", value: "+20 123 456 7890"),
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
