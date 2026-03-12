import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/features/profile/presentation/screen/widgets/privacy_section_card.dart';

class TermsOfUseScreenBody extends StatelessWidget {
  const TermsOfUseScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            PrivacySectionCard(
              title: "Acceptance of Terms",
              icon: Icons.check_circle_outline_rounded,
              iconColor: const Color(0xFF008545),
              iconBgColor: const Color(0xFFE6F6EC),
              description:
                  "By accessing and using the Tourism App, you accept and agree to be bound by these Terms of Use. If you do not agree to these terms, please do not use our services.\n\nThese terms apply to all visitors, users, and others who access or use our services.",
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: "Use of Services",
              icon: Icons.gavel_rounded,
              iconColor: const Color(0xFF134FA2),
              iconBgColor: const Color(0xFFE6F0FF),
              description:
                  "You agree to use our services only for lawful purposes and in accordance with these Terms:",
              bulletPoints: const [
                "You must be at least 18 years old to make bookings",
                "You are responsible for maintaining the confidentiality of your account",
                "You must provide accurate and complete information",
                "You will not use the service for any illegal or unauthorized purpose",
                "You will not transmit viruses, malware, or harmful code",
                "You will not interfere with or disrupt the service",
              ],
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: "Bookings and Payments",
              icon: Icons.error_outline_rounded,
              iconColor: const Color(0xFFD97706),
              iconBgColor: const Color(0xFFFFF9E5),
              description: "When making a booking through our app:",
              bulletPoints: const [
                "All bookings are subject to availability and confirmation",
                "Prices are displayed in US Dollars and may be subject to change",
                "Payment must be made in full at the time of booking",
                "You are responsible for any bank or transaction fees",
                "Refunds are subject to the cancellation policy of each service provider",
                "We reserve the right to cancel bookings in exceptional circumstances",
              ],
            ),
            SizedBox(height: 20.h),

            PrivacySectionCard(
              title: "Cancellation Policy",
              icon: Icons.cancel_outlined,
              iconColor: const Color(0xFFD32F2F),
              iconBgColor: const Color(0xFFFFEBEE),
              description: "Our cancellation policy varies by service:",
              bulletPoints: const [
                "Tour Guides & Photographers: Cancel up to 24 hours before for a full refund",
                "Day Trips: Cancel up to 48 hours before for a full refund",
                "Multi-day Trips: Cancel up to 7 days before for a full refund",
                "Late cancellations may incur fees or forfeit deposits",
                "No-shows are non-refundable",
              ],
            ),
            SizedBox(height: 20.h),

            const PrivacySectionCard(
              title: "User-Generated Content",
              description: "When you post reviews, photos, or other content:",
              bulletPoints: [
                "You grant us a license to use, display, and distribute your content",
                "You confirm that you own the rights to the content you share",
                "Content must not be offensive, defamatory, or infringe on others' rights",
                "We reserve the right to remove inappropriate content",
                "You are responsible for the accuracy of your reviews and ratings",
              ],
            ),
            SizedBox(height: 20.h),

            const PrivacySectionCard(
              title: "Intellectual Property Rights",
              description:
                  "All content, features, and functionality of the Tourism App, including but not limited to text, graphics, logos, and software, are owned by us or our licensors and are protected by copyright, trademark, and other intellectual property laws.\n\nYou may not reproduce, distribute, modify, or create derivative works without our express written permission.",
            ),
            SizedBox(height: 20.h),

            const PrivacySectionCard(
              title: "Emergency Services Disclaimer",
              description:
                  "Our emergency contact feature is provided as a convenience. In case of a real emergency:",
              bulletPoints: [
                "Always call local emergency services directly (122 for Egypt Police)",
                "The app feature connects you to tourist police, not emergency medical services",
                "We are not responsible for response times or actions taken by authorities",
              ],
            ),
            SizedBox(height: 20.h),

            const PrivacySectionCard(
              title: "Changes to Terms",
              description:
                  "We reserve the right to modify these terms at any time. We will notify you of any changes by updating the \"Last Updated\" date. Your continued use of the app after changes constitutes acceptance of the new terms.",
            ),
            SizedBox(height: 20.h),

            const PrivacySectionCard(
              title: "Governing Law",
              description:
                  "These Terms shall be governed by and construed in accordance with the laws of Egypt. Any disputes arising from these terms shall be subject to the exclusive jurisdiction of the courts in Cairo, Egypt.",
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
