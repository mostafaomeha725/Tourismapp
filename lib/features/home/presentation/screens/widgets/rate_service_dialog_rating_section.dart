import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class RateServiceDialogRatingSection extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const RateServiceDialogRatingSection({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          'Choose your rating',
          alignment: AlignmentDirectional.center,
          style: font14w500.copyWith(color: Colors.black54),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: () {
                onRatingChanged(index + 1);
              },
              icon: Icon(
                index < rating
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: Colors.amber,
                size: 40.sp,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            );
          }),
        ),
      ],
    );
  }
}
