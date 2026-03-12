import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      dense: true,
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(icon, color: const Color(0xff134FA2), size: 20.r),
      title: AppText(title, style: font12w400),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.r,
        color: const Color(0xff134FA2),
      ),
      onTap: onTap,
    );
  }
}
