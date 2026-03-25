import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/home/domain/entities/review_entity.dart';

class SubmitReviewResultEntity extends Equatable {
  final String message;
  final ReviewEntity review;

  const SubmitReviewResultEntity({required this.message, required this.review});

  @override
  List<Object?> get props => [message, review];
}
