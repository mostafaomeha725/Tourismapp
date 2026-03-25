import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/data/datasources/categories_remote_data_source.dart';
import 'package:tourismapp/features/home/domain/entities/category_entity.dart';
import 'package:tourismapp/features/home/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepositoryImpl(this.categoriesRemoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    return categoriesRemoteDataSource.getCategories();
  }
}
