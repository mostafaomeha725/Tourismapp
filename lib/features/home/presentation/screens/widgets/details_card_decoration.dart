import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration detailsCardDecoration() {
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
