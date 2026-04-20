import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/service/domain/entities/package_entity.dart';
import 'package:tourismapp/features/service/domain/repositories/packages_repository.dart';

class GetPackageByIdUseCase {
  final PackagesRepository packagesRepository;

  GetPackageByIdUseCase(this.packagesRepository);

  Future<Either<Failure, PackageEntity>> call(int packageId) {
    return packagesRepository.getPackageById(packageId);
  }
}
