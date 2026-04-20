import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/service/domain/entities/category_entity.dart';
import 'package:tourismapp/features/service/domain/repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository categoriesRepository;

  GetCategoriesUseCase(this.categoriesRepository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return categoriesRepository.getCategories();
  }
}
