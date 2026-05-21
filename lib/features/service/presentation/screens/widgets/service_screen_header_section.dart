import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class ServiceScreenHeaderSection extends StatelessWidget {
  const ServiceScreenHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(height: 16.h),
        AppText(
          loc.distinctiveTourismServices,
          style: font20w700,
          overflow: TextOverflow.visible,
        ),
        SizedBox(height: 4.h),
        AppText(
          loc.bookGuidesPhotographersAndTours,
          overflow: TextOverflow.visible,
          style: font14w400.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
