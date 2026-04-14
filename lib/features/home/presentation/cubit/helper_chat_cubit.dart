import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/home/domain/usecases/send_helper_chat_message_usecase.dart';

part 'helper_chat_state.dart';

class HelperChatCubit extends Cubit<HelperChatState> {
  static const String _welcomeMessage =
      'Welcome! I am your Egypt Tourism Assistant. Ask me about places, itineraries, costs, and transport.';

  final SendHelperChatMessageUseCase sendHelperChatMessageUseCase;

  HelperChatCubit(this.sendHelperChatMessageUseCase)
    : super(
        HelperChatSuccess(
          messages: [
            HelperChatUiMessage(
              text: _welcomeMessage,
              isFromUser: false,
              createdAt: DateTime.now(),
            ),
          ],
        ),
      );

  Future<void> sendMessage(String input) async {
    if (state is HelperChatLoading) {
      return;
    }

    final text = input.trim();
    if (text.isEmpty) {
      return;
    }

    final userMessage = HelperChatUiMessage(
      text: text,
      isFromUser: true,
      createdAt: DateTime.now(),
    );

    final currentMessages = [...state.messages, userMessage];
    emit(HelperChatLoading(messages: currentMessages));

    final result = await sendHelperChatMessageUseCase(text);

    result.fold(
      (failure) {
        final errorReply = HelperChatUiMessage(
          text: failure.message,
          isFromUser: false,
          createdAt: DateTime.now(),
        );
        emit(
          HelperChatError(
            messages: [...currentMessages, errorReply],
            errorMessage: failure.message,
          ),
        );
      },
      (reply) {
        final botReply = HelperChatUiMessage(
          text: reply,
          isFromUser: false,
          createdAt: DateTime.now(),
        );
        emit(HelperChatSuccess(messages: [...currentMessages, botReply]));
      },
    );
  }
}
