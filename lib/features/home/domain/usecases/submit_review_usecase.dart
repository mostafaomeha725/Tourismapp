import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/error/failure.dart';
import 'package:tourismapp/features/home/domain/entities/submit_review_result_entity.dart';
import 'package:tourismapp/features/home/domain/repositories/packages_repository.dart';

class SubmitReviewUseCase {
  final PackagesRepository packagesRepository;

  SubmitReviewUseCase(this.packagesRepository);

  Future<Either<Failure, SubmitReviewResultEntity>> call(
    SubmitReviewParams params,
  ) {
    return packagesRepository.submitReview(params);
  }
}

class SubmitReviewParams extends Equatable {
  final int packageId;
  final int rating;
  final String comment;

  const SubmitReviewParams({
    required this.packageId,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {'package_id': packageId, 'rating': rating, 'comment': comment};
  }

  @override
  List<Object?> get props => [packageId, rating, comment];
}
