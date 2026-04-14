part of 'helper_chat_cubit.dart';

class HelperChatUiMessage extends Equatable {
  final String text;
  final bool isFromUser;
  final DateTime createdAt;

  const HelperChatUiMessage({
    required this.text,
    required this.isFromUser,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [text, isFromUser, createdAt];
}

abstract class HelperChatState extends Equatable {
  final List<HelperChatUiMessage> messages;

  const HelperChatState({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class HelperChatEmpty extends HelperChatState {
  const HelperChatEmpty() : super(messages: const []);
}

class HelperChatLoading extends HelperChatState {
  const HelperChatLoading({required super.messages});
}

class HelperChatSuccess extends HelperChatState {
  const HelperChatSuccess({required super.messages});
}

class HelperChatError extends HelperChatState {
  final String errorMessage;

  const HelperChatError({required super.messages, required this.errorMessage});

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
