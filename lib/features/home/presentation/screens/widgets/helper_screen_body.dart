import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourismapp/features/home/presentation/cubit/helper_chat_cubit.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/helper_chat_header.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/helper_chat_input_bar.dart';
import 'package:tourismapp/features/home/presentation/screens/widgets/helper_chat_message_bubble.dart';

class HelperScreenBody extends StatefulWidget {
  const HelperScreenBody({super.key});

  @override
  State<HelperScreenBody> createState() => _HelperScreenBodyState();
}

class _HelperScreenBodyState extends State<HelperScreenBody> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    context.read<HelperChatCubit>().sendMessage(text);
    controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HelperChatHeader(),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(12.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: const Color(0xffF0F1F3), width: 1),
              ),
              child: BlocBuilder<HelperChatCubit, HelperChatState>(
                builder: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    }
                  });

                  final visibleMessages = [
                    ...state.messages,
                    if (state is HelperChatLoading)
                      HelperChatUiMessage(
                        text: 'Typing...',
                        isFromUser: false,
                        createdAt: DateTime.now(),
                      ),
                  ];

                  return ListView.builder(
                    controller: scrollController,
                    itemCount: visibleMessages.length,
                    itemBuilder: (context, index) {
                      return HelperChatMessageBubble(
                        message: visibleMessages[index],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          BlocBuilder<HelperChatCubit, HelperChatState>(
            builder: (context, state) {
              return HelperChatInputBar(
                controller: controller,
                isSending: state is HelperChatLoading,
                onSend: sendMessage,
              );
            },
          ),
        ],
      ),
    );
  }
}
