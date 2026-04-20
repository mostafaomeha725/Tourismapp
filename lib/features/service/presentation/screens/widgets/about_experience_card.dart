import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/details_card_decoration.dart';

class AboutExperienceCard extends StatelessWidget {
  final String description;

  const AboutExperienceCard({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: detailsCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('About This Experience', style: font18w700),
          SizedBox(height: 12.h),
          AppText(
            description,
            style: font14w500,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
