part of 'submit_review_cubit.dart';

sealed class SubmitReviewState extends Equatable {
  const SubmitReviewState();

  @override
  List<Object?> get props => [];
}

final class SubmitReviewInitial extends SubmitReviewState {}

final class SubmitReviewLoading extends SubmitReviewState {}

final class SubmitReviewSuccess extends SubmitReviewState {
  final SubmitReviewResultEntity result;

  const SubmitReviewSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

final class SubmitReviewFailure extends SubmitReviewState {
  final String message;

  const SubmitReviewFailure(this.message);

  @override
  List<Object?> get props => [message];
}
