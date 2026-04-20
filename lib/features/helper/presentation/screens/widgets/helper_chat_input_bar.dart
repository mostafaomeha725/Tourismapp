import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/core/theme/light_colors.dart';
import 'package:tourismapp/core/widgets/app_form_field.dart';
import 'package:tourismapp/core/widgets/bouncing_widgets.dart';

class HelperChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;

  const HelperChatInputBar({
    super.key,
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          Expanded(
            child: AppFormField(
              controller: controller,
              hintText: 'Type your message...',
              onFieldSubmitted: (_) => onSend(),
              maxLines: 3,
              minLines: 1,
              radius: 18.r,
              fillColor: Colors.white,
              borderColor: const Color(0xffF0F1F3),
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.h,
                horizontal: 16.w,
              ),
              prefixIcon: Icon(
                Icons.edit_outlined,
                color: Colors.grey.shade500,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          BounceIt(
            onPressed: isSending ? null : onSend,
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: isSending
                    ? Colors.orange.shade200
                    : AppLightColors.primary,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.32),
                    blurRadius: 8.r,
                    offset: Offset(0, 3.h),
                  ),
                ],
              ),
              child: Icon(Icons.send, color: Colors.white, size: 22.sp),
            ),
          ),
        ],
      ),
    );
  }
}
