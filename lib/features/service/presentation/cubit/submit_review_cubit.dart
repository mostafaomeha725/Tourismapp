import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/service/domain/entities/submit_review_result_entity.dart';
import 'package:tourismapp/features/service/domain/usecases/submit_review_usecase.dart';

part 'submit_review_state.dart';

class SubmitReviewCubit extends Cubit<SubmitReviewState> {
  final SubmitReviewUseCase submitReviewUseCase;

  SubmitReviewCubit(this.submitReviewUseCase) : super(SubmitReviewInitial());

  Future<void> submitReview({
    required int packageId,
    required int rating,
    required String comment,
  }) async {
    emit(SubmitReviewLoading());

    final result = await submitReviewUseCase(
      SubmitReviewParams(
        packageId: packageId,
        rating: rating,
        comment: comment,
      ),
    );

    result.fold(
      (failure) => emit(SubmitReviewFailure(failure.message)),
      (success) => emit(SubmitReviewSuccess(success)),
    );
  }
}
