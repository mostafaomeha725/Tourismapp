import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/helper/data/data_sources/helper_chat_remote_data_source.dart';
import 'package:tourismapp/features/helper/domain/repositories/helper_chat_repository.dart';

class HelperChatRepositoryImpl implements HelperChatRepository {
  final HelperChatRemoteDataSource helperChatRemoteDataSource;

  HelperChatRepositoryImpl(this.helperChatRemoteDataSource);

  @override
  Future<Either<Failure, String>> askQuestion(String question) async {
    return helperChatRemoteDataSource.askQuestion(question);
  }
}
