import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/data/datasources/packages_remote_data_source.dart';
import 'package:tourismapp/features/home/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/domain/entities/packages_page_entity.dart';
import 'package:tourismapp/features/home/domain/entities/price_range_entity.dart';
import 'package:tourismapp/features/home/domain/entities/submit_review_result_entity.dart';
import 'package:tourismapp/features/home/domain/repositories/packages_repository.dart';
import 'package:tourismapp/features/home/domain/usecases/get_packages_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/submit_review_usecase.dart';

class PackagesRepositoryImpl implements PackagesRepository {
  final PackagesRemoteDataSource packagesRemoteDataSource;

  PackagesRepositoryImpl(this.packagesRemoteDataSource);

  @override
  Future<Either<Failure, PackagesPageEntity>> getPackages(
    GetPackagesParams params,
  ) async {
    return packagesRemoteDataSource.getPackages(params);
  }

  @override
  Future<Either<Failure, PackageEntity>> getPackageById(int packageId) async {
    return packagesRemoteDataSource.getPackageById(packageId);
  }

  @override
  Future<Either<Failure, SubmitReviewResultEntity>> submitReview(
    SubmitReviewParams params,
  ) async {
    return packagesRemoteDataSource.submitReview(params);
  }

  @override
  Future<Either<Failure, PriceRangeEntity>> getPackagesPriceRange() async {
    return packagesRemoteDataSource.getPackagesPriceRange();
  }
}
