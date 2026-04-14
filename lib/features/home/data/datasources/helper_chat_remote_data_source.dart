import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/core/network/endpoints.dart';
import 'package:tourismapp/core/network/network_service.dart';

abstract class HelperChatRemoteDataSource {
  Future<Either<Failure, String>> askQuestion(String question);
}

class HelperChatRemoteDataSourceImpl implements HelperChatRemoteDataSource {
  final NetworkService networkService;

  HelperChatRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<Failure, String>> askQuestion(String question) async {
    final response = await networkService.postData(
      endPoint: EndPoints.chatbot,
      data: {'question': question.trim()},
    );

    return response.fold(Left.new, (data) {
      if (data is! Map<String, dynamic>) {
        return const Left(Failure('Unexpected response format'));
      }

      final directAnswer = data['answer']?.toString().trim();
      if (directAnswer != null && directAnswer.isNotEmpty) {
        return Right(directAnswer);
      }

      final payload = data['data'];
      if (payload is Map<String, dynamic>) {
        final nestedAnswer = payload['answer']?.toString().trim();
        if (nestedAnswer != null && nestedAnswer.isNotEmpty) {
          return Right(nestedAnswer);
        }
      }

      return const Left(Failure('Answer was not found in response'));
    });
  }
}
