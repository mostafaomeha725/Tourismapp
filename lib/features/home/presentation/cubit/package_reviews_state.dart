part of 'package_reviews_cubit.dart';

class PackageReviewsState extends Equatable {
  final RequestState status;
  final List<ReviewEntity> reviews;
  final int currentPage;
  final int totalPages;
  final String? errorMessage;

  const PackageReviewsState({
    required this.status,
    required this.reviews,
    required this.currentPage,
    required this.totalPages,
    this.errorMessage,
  });

  const PackageReviewsState.initial()
    : status = RequestState.init,
      reviews = const [],
      currentPage = 1,
      totalPages = 1,
      errorMessage = null;

  PackageReviewsState copyWith({
    RequestState? status,
    List<ReviewEntity>? reviews,
    int? currentPage,
    int? totalPages,
    String? errorMessage,
  }) {
    return PackageReviewsState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    reviews,
    currentPage,
    totalPages,
    errorMessage,
  ];
}
