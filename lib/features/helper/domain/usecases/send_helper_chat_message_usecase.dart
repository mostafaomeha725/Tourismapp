import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/helper/domain/repositories/helper_chat_repository.dart';

class SendHelperChatMessageUseCase {
  final HelperChatRepository helperChatRepository;

  SendHelperChatMessageUseCase(this.helperChatRepository);

  Future<Either<Failure, String>> call(String question) {
    return helperChatRepository.askQuestion(question);
  }
}
