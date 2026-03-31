import 'package:equatable/equatable.dart';

class HelperChatMessageEntity extends Equatable {
  final String text;
  final bool isFromUser;
  final DateTime createdAt;

  const HelperChatMessageEntity({
    required this.text,
    required this.isFromUser,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [text, isFromUser, createdAt];
}
