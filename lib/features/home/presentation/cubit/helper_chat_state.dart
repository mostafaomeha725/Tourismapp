part of 'helper_chat_cubit.dart';

class HelperChatState extends Equatable {
  final List<HelperChatMessageEntity> messages;
  final bool isSending;
  final String? error;

  const HelperChatState({
    required this.messages,
    required this.isSending,
    this.error,
  });

  factory HelperChatState.initial(List<HelperChatMessageEntity> initial) {
    return HelperChatState(messages: initial, isSending: false, error: null);
  }

  HelperChatState copyWith({
    List<HelperChatMessageEntity>? messages,
    bool? isSending,
    String? error,
  }) {
    return HelperChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      error: error,
    );
  }

  @override
  List<Object?> get props => [messages, isSending, error];
}
