import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/category_entity.dart';
import 'package:tourismapp/features/home/domain/repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository categoriesRepository;

  GetCategoriesUseCase(this.categoriesRepository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return categoriesRepository.getCategories();
  }
}
