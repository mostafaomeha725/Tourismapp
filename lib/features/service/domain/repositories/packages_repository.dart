import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/service/domain/entities/favorite_toggle_result_entity.dart';
import 'package:tourismapp/features/service/domain/entities/package_entity.dart';
import 'package:tourismapp/features/service/domain/entities/packages_page_entity.dart';
import 'package:tourismapp/features/service/domain/entities/price_range_entity.dart';
import 'package:tourismapp/features/service/domain/entities/reviews_page_entity.dart';
import 'package:tourismapp/features/service/domain/entities/submit_review_result_entity.dart';
import 'package:tourismapp/features/service/domain/usecases/get_packages_usecase.dart';
import 'package:tourismapp/features/service/domain/usecases/submit_review_usecase.dart';

abstract class PackagesRepository {
  Future<Either<Failure, PackagesPageEntity>> getPackages(
    GetPackagesParams params,
  );

  Future<Either<Failure, PackageEntity>> getPackageById(int packageId);

  Future<Either<Failure, SubmitReviewResultEntity>> submitReview(
    SubmitReviewParams params,
  );

  Future<Either<Failure, ReviewsPageEntity>> getPackageReviews(
    int packageId, {
    int? page,
  });

  Future<Either<Failure, FavoriteToggleResultEntity>> toggleFavorite(
    int packageId,
  );

  Future<Either<Failure, PackagesPageEntity>> getFavorites({int? page});

  Future<Either<Failure, PriceRangeEntity>> getPackagesPriceRange();
}
