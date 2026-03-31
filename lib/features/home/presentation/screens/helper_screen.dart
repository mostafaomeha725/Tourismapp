import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tourismapp/core/constants/app_assets.dart';
import 'package:tourismapp/core/theme/styles.dart';
import 'package:tourismapp/core/widgets/app_asset.dart';
import 'package:tourismapp/core/widgets/custom_text.dart';
import 'package:tourismapp/features/home/domain/entities/helper_chat_message_entity.dart';
import 'package:tourismapp/features/home/presentation/cubit/helper_chat_cubit.dart';

class HelperScreen extends StatefulWidget {
  const HelperScreen({super.key});

  @override
  State<HelperScreen> createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    context.read<HelperChatCubit>().sendMessage(text);
    controller.clear();
    FocusScope.of(context).unfocus();
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  Widget _buildMessageBubble(HelperChatMessageEntity msg) {
    final isUser = msg.isFromUser;

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
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12.w),
              constraints: BoxConstraints(maxWidth: 260.w),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xffdb6000) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    msg.text,
                    overflow: TextOverflow.visible,
                    style: font14w400.copyWith(
                      color: isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  AppText(
                    _formatTime(msg.createdAt),
                    style: font10w400.copyWith(
                      color: isUser ? Colors.white70 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF9EE),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15.w),
                    margin: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        AppAsset(
                          assetName: Assets.chatbot,
                          width: 32.w,
                          height: 32.h,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText('Tourist Assistant', style: font18w700),
                            SizedBox(height: 3.h),
                            AppText(
                              'Ask me about tourism in Egypt',
                              style: font12w400.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: AppText(
                            'Online',
                            style: font12w500.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      padding: EdgeInsets.all(12.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: BlocBuilder<HelperChatCubit, HelperChatState>(
                        builder: (context, state) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_scrollController.hasClients) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                              );
                            }
                          });

                          final visibleMessages = [
                            ...state.messages,
                            if (state.isSending)
                              HelperChatMessageEntity(
                                text: 'Typing...',
                                isFromUser: false,
                                createdAt: DateTime.now(),
                              ),
                          ];

                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: visibleMessages.length,
                            itemBuilder: (context, index) {
                              return _buildMessageBubble(
                                visibleMessages[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 16.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  BlocBuilder<HelperChatCubit, HelperChatState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: state.isSending ? null : _sendMessage,
                        child: Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: state.isSending
                                ? Colors.orange.shade200
                                : Colors.orange,
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
