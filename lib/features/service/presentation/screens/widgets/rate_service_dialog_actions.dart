import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/widgets/custom_button.dart';
import 'package:tourismapp/l10n/app_localizations.dart';

class RateServiceDialogActions extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  const RateServiceDialogActions({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AppButton(
            text: loc.submitReview,
            onPressed: onSubmit,
            height: 48.h,
            color: Colors.orange,
            textSize: 16.sp,
            textWeight: FontWeight.bold,
            textColor: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: AppButton(
            text: loc.cancel,
            onPressed: onCancel,
            height: 48.h,
            textColor: Colors.black,
            borderColor: Colors.grey,
            color: Colors.white,
            textSize: 16.sp,
            textWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
