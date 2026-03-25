import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/price_range_entity.dart';
import 'package:tourismapp/features/home/domain/repositories/packages_repository.dart';

class GetPackagesPriceRangeUseCase {
  final PackagesRepository packagesRepository;

  GetPackagesPriceRangeUseCase(this.packagesRepository);

  Future<Either<Failure, PriceRangeEntity>> call() {
    return packagesRepository.getPackagesPriceRange();
  }
}
