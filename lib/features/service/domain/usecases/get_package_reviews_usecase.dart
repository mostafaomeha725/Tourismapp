import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/service/domain/entities/reviews_page_entity.dart';
import 'package:tourismapp/features/service/domain/repositories/packages_repository.dart';

class GetPackageReviewsUseCase {
  final PackagesRepository packagesRepository;

  GetPackageReviewsUseCase(this.packagesRepository);

  Future<Either<Failure, ReviewsPageEntity>> call(
    GetPackageReviewsParams params,
  ) {
    return packagesRepository.getPackageReviews(
      params.packageId,
      page: params.page,
    );
  }
}

class GetPackageReviewsParams extends Equatable {
  final int packageId;
  final int? page;

  const GetPackageReviewsParams({required this.packageId, this.page});

  @override
  List<Object?> get props => [packageId, page];
}
