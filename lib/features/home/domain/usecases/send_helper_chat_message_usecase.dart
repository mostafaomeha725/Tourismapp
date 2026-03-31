import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/helper_chat_message_entity.dart';
import 'package:tourismapp/features/home/domain/repositories/helper_chat_repository.dart';

class SendHelperChatMessageUseCase {
  final HelperChatRepository helperChatRepository;

  SendHelperChatMessageUseCase(this.helperChatRepository);

  Future<Either<Failure, String>> call(SendHelperChatMessageParams params) {
    return helperChatRepository.sendMessage(
      message: params.message,
      history: params.history,
    );
  }
}

class SendHelperChatMessageParams extends Equatable {
  final String message;
  final List<HelperChatMessageEntity> history;

  const SendHelperChatMessageParams({
    required this.message,
    required this.history,
  });

  @override
  List<Object?> get props => [message, history];
}
