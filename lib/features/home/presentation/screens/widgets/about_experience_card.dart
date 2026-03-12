import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class AboutExperienceCard extends StatelessWidget {
  const AboutExperienceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: commonDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('About This Experience', style: font18w700),
          SizedBox(height: 12.h),
          AppText(
            'Discover the magnificent Pyramids of Giza with Ahmed, an expert tour guide with over 10 years of experience. He specializes in ancient Egyptian history and archaeology, fluently speaking Arabic, English, and French. Ahmed will take you on an unforgettable journey through time, sharing fascinating stories about the pharaohs, the construction of the pyramids, and the mysteries that still surround these ancient wonders. Perfect for history enthusiasts and families alike.',
            style: font14w500,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}

BoxDecoration commonDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.r),
    // ignore: deprecated_member_use
    border: Border.all(color: Colors.grey.withOpacity(0.1)),
    boxShadow: [
      BoxShadow(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10.r,
        spreadRadius: 2.r,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
