import 'package:dartz/dartz.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/core/network/endpoints.dart';
import 'package:tourismapp/core/network/network_service.dart';
import 'package:tourismapp/features/home/data/models/favorite_toggle_result_model.dart';
import 'package:tourismapp/features/home/data/models/package_model.dart';
import 'package:tourismapp/features/home/data/models/packages_page_model.dart';
import 'package:tourismapp/features/home/data/models/price_range_model.dart';
import 'package:tourismapp/features/home/data/models/reviews_page_model.dart';
import 'package:tourismapp/features/home/data/models/submit_review_result_model.dart';
import 'package:tourismapp/features/home/domain/usecases/get_packages_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/submit_review_usecase.dart';

abstract class PackagesRemoteDataSource {
  Future<Either<Failure, PackagesPageModel>> getPackages(
    GetPackagesParams params,
  );

  Future<Either<Failure, PackageModel>> getPackageById(int packageId);

  Future<Either<Failure, SubmitReviewResultModel>> submitReview(
    SubmitReviewParams params,
  );

  Future<Either<Failure, ReviewsPageModel>> getPackageReviews(
    int packageId, {
    int? page,
  });

  Future<Either<Failure, FavoriteToggleResultModel>> toggleFavorite(
    int packageId,
  );

  Future<Either<Failure, PackagesPageModel>> getFavorites({int? page});

  Future<Either<Failure, PriceRangeModel>> getPackagesPriceRange();
}

class PackagesRemoteDataSourceImpl implements PackagesRemoteDataSource {
  final NetworkService networkService;

  PackagesRemoteDataSourceImpl(this.networkService);

  @override
  Future<Either<Failure, PackagesPageModel>> getPackages(
    GetPackagesParams params,
  ) async {
    final response = await networkService.getData(
      endPoint: EndPoints.packages,
      queryParameters: params.toQueryParameters(),
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        return Right(PackagesPageModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }

  @override
  Future<Either<Failure, PackageModel>> getPackageById(int packageId) async {
    final response = await networkService.getData(
      endPoint: EndPoints.packageDetails(packageId),
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        final payload = data['data'];
        if (payload is Map<String, dynamic>) {
          return Right(PackageModel.fromJson(payload));
        }
        return Right(PackageModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }

  @override
  Future<Either<Failure, SubmitReviewResultModel>> submitReview(
    SubmitReviewParams params,
  ) async {
    final response = await networkService.postData(
      endPoint: EndPoints.reviews,
      data: params.toJson(),
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        return Right(SubmitReviewResultModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }

  @override
  Future<Either<Failure, ReviewsPageModel>> getPackageReviews(
    int packageId, {
    int? page,
  }) async {
    final response = await networkService.getData(
      endPoint: EndPoints.packageReviews(packageId),
      queryParameters: {if (page != null) 'page': page},
    );

    return response.fold(Left.new, (data) {
      if (data is! Map<String, dynamic>) {
        return const Left(Failure('Unexpected response format'));
      }

      return Right(ReviewsPageModel.fromJson(data));
    });
  }

  @override
  Future<Either<Failure, FavoriteToggleResultModel>> toggleFavorite(
    int packageId,
  ) async {
    final response = await networkService.postData(
      endPoint: EndPoints.favoritesToggle,
      data: {'package_id': packageId},
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        return Right(FavoriteToggleResultModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }

  @override
  Future<Either<Failure, PackagesPageModel>> getFavorites({int? page}) async {
    final response = await networkService.getData(
      endPoint: EndPoints.favorites,
      queryParameters: {if (page != null) 'page': page},
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        return Right(PackagesPageModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }

  @override
  Future<Either<Failure, PriceRangeModel>> getPackagesPriceRange() async {
    final response = await networkService.getData(
      endPoint: EndPoints.packagesPriceRange,
    );

    return response.fold(Left.new, (data) {
      if (data is Map<String, dynamic>) {
        return Right(PriceRangeModel.fromJson(data));
      }
      return const Left(Failure('Unexpected response format'));
    });
  }
}
