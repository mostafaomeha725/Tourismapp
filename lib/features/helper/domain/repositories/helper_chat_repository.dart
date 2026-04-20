import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';

abstract class HelperChatRepository {
  Future<Either<Failure, String>> askQuestion(String question);
}
