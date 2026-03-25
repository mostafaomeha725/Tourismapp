import 'package:tourismapp/features/home/data/models/review_model.dart';
import 'package:tourismapp/features/home/domain/entities/submit_review_result_entity.dart';

class SubmitReviewResultModel extends SubmitReviewResultEntity {
  const SubmitReviewResultModel({
    required super.message,
    required super.review,
  });

  factory SubmitReviewResultModel.fromJson(Map<String, dynamic> json) {
    return SubmitReviewResultModel(
      message: (json['message'] ?? 'Review submitted.').toString(),
      review: ReviewModel.fromJson(
        (json['review'] as Map<String, dynamic>?) ?? const {},
      ),
    );
  }
}
