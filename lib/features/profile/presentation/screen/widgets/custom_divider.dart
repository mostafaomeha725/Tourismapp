import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 16.w,
      endIndent: 16.w,
      height: 1.h,
      thickness: 1,
      color: Colors.grey.shade300,
    );
  }
}
