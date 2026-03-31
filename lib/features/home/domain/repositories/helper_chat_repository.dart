import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/helper_chat_message_entity.dart';

abstract class HelperChatRepository {
  Future<Either<Failure, String>> sendMessage({
    required String message,
    required List<HelperChatMessageEntity> history,
  });
}
