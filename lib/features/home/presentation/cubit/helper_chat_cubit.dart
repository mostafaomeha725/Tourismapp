import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/home/domain/entities/helper_chat_message_entity.dart';
import 'package:tourismapp/features/home/domain/usecases/send_helper_chat_message_usecase.dart';

part 'helper_chat_state.dart';

class HelperChatCubit extends Cubit<HelperChatState> {
  final SendHelperChatMessageUseCase sendHelperChatMessageUseCase;

  HelperChatCubit(this.sendHelperChatMessageUseCase)
    : super(
        HelperChatState.initial([
          HelperChatMessageEntity(
            text:
                'Welcome! I am your Egypt Tourism Assistant. Ask me about places, itineraries, costs, and transport.',
            isFromUser: false,
            createdAt: DateTime.now(),
          ),
        ]),
      );

  Future<void> sendMessage(String input) async {
    final text = input.trim();
    if (text.isEmpty || state.isSending) {
      return;
    }

    final userMessage = HelperChatMessageEntity(
      text: text,
      isFromUser: true,
      createdAt: DateTime.now(),
    );

    final currentMessages = [...state.messages, userMessage];
    emit(
      state.copyWith(messages: currentMessages, isSending: true, error: null),
    );

    final result = await sendHelperChatMessageUseCase(
      SendHelperChatMessageParams(message: text, history: currentMessages),
    );

    result.fold(
      (failure) {
        final errorReply = HelperChatMessageEntity(
          text: failure.message,
          isFromUser: false,
          createdAt: DateTime.now(),
        );
        emit(
          state.copyWith(
            messages: [...currentMessages, errorReply],
            isSending: false,
            error: failure.message,
          ),
        );
      },
      (reply) {
        final botReply = HelperChatMessageEntity(
          text: reply,
          isFromUser: false,
          createdAt: DateTime.now(),
        );
        emit(
          state.copyWith(
            messages: [...currentMessages, botReply],
            isSending: false,
            error: null,
          ),
        );
      },
    );
  }
}
