import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/favorite_toggle_result_entity.dart';
import 'package:tourismapp/features/home/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/domain/entities/packages_page_entity.dart';
import 'package:tourismapp/features/home/domain/entities/price_range_entity.dart';
import 'package:tourismapp/features/home/domain/entities/submit_review_result_entity.dart';
import 'package:tourismapp/features/home/domain/usecases/get_packages_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/submit_review_usecase.dart';

abstract class PackagesRepository {
  Future<Either<Failure, PackagesPageEntity>> getPackages(
    GetPackagesParams params,
  );

  Future<Either<Failure, PackageEntity>> getPackageById(int packageId);

  Future<Either<Failure, SubmitReviewResultEntity>> submitReview(
    SubmitReviewParams params,
  );

  Future<Either<Failure, FavoriteToggleResultEntity>> toggleFavorite(
    int packageId,
  );

  Future<Either<Failure, PackagesPageEntity>> getFavorites({int? page});

  Future<Either<Failure, PriceRangeEntity>> getPackagesPriceRange();
}
