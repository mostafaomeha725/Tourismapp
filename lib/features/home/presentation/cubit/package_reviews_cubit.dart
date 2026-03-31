import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/home/domain/entities/review_entity.dart';
import 'package:tourismapp/features/home/domain/usecases/get_package_reviews_usecase.dart';

part 'package_reviews_state.dart';

class PackageReviewsCubit extends Cubit<PackageReviewsState> {
  final GetPackageReviewsUseCase getPackageReviewsUseCase;

  PackageReviewsCubit(this.getPackageReviewsUseCase)
    : super(const PackageReviewsState.initial());

  Future<void> loadReviews({required int packageId, int page = 1}) async {
    emit(
      state.copyWith(
        status: RequestState.loading,
        currentPage: page,
        errorMessage: null,
      ),
    );

    final result = await getPackageReviewsUseCase(
      GetPackageReviewsParams(packageId: packageId, page: page),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (reviewsPage) => emit(
        state.copyWith(
          status: RequestState.success,
          reviews: reviewsPage.items,
          currentPage: reviewsPage.currentPage,
          totalPages: reviewsPage.lastPage,
          errorMessage: null,
        ),
      ),
    );
  }
}
