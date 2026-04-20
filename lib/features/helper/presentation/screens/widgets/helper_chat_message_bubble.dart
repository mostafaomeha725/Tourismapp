import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/helper/presentation/cubit/helper_chat_cubit.dart';

class HelperChatMessageBubble extends StatelessWidget {
  final HelperChatUiMessage message;

  const HelperChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isFromUser;
    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(message.text);
    final isRtlContent = isUser ? true : hasArabic;
    final textDirection = isRtlContent ? TextDirection.rtl : TextDirection.ltr;
    final textAlign = isRtlContent ? TextAlign.right : TextAlign.left;
    final textAlignment = isRtlContent
        ? AlignmentDirectional.topEnd
        : AlignmentDirectional.topStart;
    final bubbleColor = isUser
        ? const Color(0xffdb6000)
        : const Color(0xffF5F7FA);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            AppAsset(assetName: Assets.chatbot, width: 32.w, height: 32.h),
            SizedBox(width: 6.w),
          ],
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 0.76.sw),
            child: IntrinsicWidth(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  border: isUser
                      ? null
                      : Border.all(color: const Color(0xffE8EBF0), width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                    bottomLeft: Radius.circular(isUser ? 14.r : 4.r),
                    bottomRight: Radius.circular(isUser ? 4.r : 14.r),
                  ),
                ),
                child: Directionality(
                  textDirection: textDirection,
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        message.text,
                        alignment: textAlignment,
                        overflow: TextOverflow.visible,
                        textAlign: textAlign,
                        style: font14w400.copyWith(
                          color: isUser ? Colors.white : Colors.black87,
                          height: 1.35,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      AppText(
                        DateFormat('hh:mm a').format(message.createdAt),
                        alignment: textAlignment,
                        textAlign: textAlign,
                        style: font10w400.copyWith(
                          color: isUser ? Colors.white70 : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
