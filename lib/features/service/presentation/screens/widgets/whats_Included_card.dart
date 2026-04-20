import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/details_card_decoration.dart';
import 'package:tourismapp/features/service/presentation/screens/widgets/include_item_row.dart';

class WhatsIncludedCard extends StatelessWidget {
  final List<String> whatsIncluded;

  const WhatsIncludedCard({super.key, required this.whatsIncluded});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: detailsCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            "What's Included",
            style: font18w700.copyWith(color: Colors.black87),
          ),
          SizedBox(height: 16.h),
          if (whatsIncluded.isEmpty)
            AppText(
              'No included items provided yet',
              style: font14w500.copyWith(color: Colors.black54),
            )
          else
            ...whatsIncluded.map((item) => IncludedItemRow(text: item)),
        ],
      ),
    );
  }
}
