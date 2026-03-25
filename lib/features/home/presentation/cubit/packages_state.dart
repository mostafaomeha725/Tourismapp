part of 'packages_cubit.dart';

class PackagesState extends Equatable {
  final RequestState status;
  final List<PackageEntity> packages;
  final List<PlaceEntity> places;
  final List<CategoryEntity> categories;
  final int currentPage;
  final int totalPages;
  final double minPrice;
  final double maxPrice;
  final String? errorMessage;

  const PackagesState({
    required this.status,
    required this.packages,
    required this.places,
    required this.categories,
    required this.currentPage,
    required this.totalPages,
    required this.minPrice,
    required this.maxPrice,
    this.errorMessage,
  });

  const PackagesState.initial()
    : status = RequestState.init,
      packages = const [],
      places = const [],
      categories = const [],
      currentPage = 1,
      totalPages = 1,
      minPrice = 0,
      maxPrice = 300,
      errorMessage = null;

  PackagesState copyWith({
    RequestState? status,
    List<PackageEntity>? packages,
    List<PlaceEntity>? places,
    List<CategoryEntity>? categories,
    int? currentPage,
    int? totalPages,
    double? minPrice,
    double? maxPrice,
    String? errorMessage,
  }) {
    return PackagesState(
      status: status ?? this.status,
      packages: packages ?? this.packages,
      places: places ?? this.places,
      categories: categories ?? this.categories,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    packages,
    places,
    categories,
    currentPage,
    totalPages,
    minPrice,
    maxPrice,
    errorMessage,
  ];
}
