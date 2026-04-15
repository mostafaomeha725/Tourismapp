import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class RateServiceDialogHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const RateServiceDialogHeader({
    super.key,
    required this.title,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              AppText(
                'Rate Service',
                style: font20w700,
                alignment: AlignmentDirectional.center,
              ),
              SizedBox(height: 8.h),
              AppText(
                title,
                alignment: AlignmentDirectional.center,
                style: font14w400.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: onClose,
            child: Icon(Icons.close, color: Colors.grey, size: 24.sp),
          ),
        ),
      ],
    );
  }
}
