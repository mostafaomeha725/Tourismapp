import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/core/network/endpoints.dart';
import 'package:tourismapp/core/network/network_service.dart';
import 'package:tourismapp/features/service/data/models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final NetworkService networkService;

  CategoriesRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    final response = await networkService.getData(
      endPoint: EndPoints.categories,
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        final list = data['data'];
        if (list is List) {
          return Right(
            list
                .whereType<Map<String, dynamic>>()
                .map(CategoryModel.fromJson)
                .toList(),
          );
        }
      }
      return const Left(Failure('Unexpected response format'));
    });
  }
}
