part of 'packages_cubit.dart';

enum PackagesActionType { openPackageDetails, openExternalLink, showError }

class PackagesAction extends Equatable {
  final PackagesActionType type;
  final int? packageId;
  final String? url;
  final String? message;

  const PackagesAction._({
    required this.type,
    this.packageId,
    this.url,
    this.message,
  });

  const PackagesAction.openPackageDetails(int packageId)
    : this._(type: PackagesActionType.openPackageDetails, packageId: packageId);

  const PackagesAction.openExternalLink(String url)
    : this._(type: PackagesActionType.openExternalLink, url: url);

  const PackagesAction.showError(String message)
    : this._(type: PackagesActionType.showError, message: message);

  @override
  List<Object?> get props => [type, packageId, url, message];
}

class PackagesState extends Equatable {
  final RequestState status;
  final List<PackageEntity> packages;
  final List<PlaceEntity> places;
  final List<CategoryEntity> categories;
  final int currentPage;
  final int totalPages;
  final double minPrice;
  final double maxPrice;
  final bool isPageChangeLoading;
  final int? loadingPageNumber;
  final int scrollToTopSignal;
  final String? errorMessage;
  final PackagesAction? pendingAction;
  final int actionNonce;

  const PackagesState({
    required this.status,
    required this.packages,
    required this.places,
    required this.categories,
    required this.currentPage,
    required this.totalPages,
    required this.minPrice,
    required this.maxPrice,
    required this.isPageChangeLoading,
    required this.loadingPageNumber,
    required this.scrollToTopSignal,
    this.errorMessage,
    required this.pendingAction,
    required this.actionNonce,
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
      isPageChangeLoading = false,
      loadingPageNumber = null,
      scrollToTopSignal = 0,
      errorMessage = null,
      pendingAction = null,
      actionNonce = 0;

  PackagesState copyWith({
    RequestState? status,
    List<PackageEntity>? packages,
    List<PlaceEntity>? places,
    List<CategoryEntity>? categories,
    int? currentPage,
    int? totalPages,
    double? minPrice,
    double? maxPrice,
    bool? isPageChangeLoading,
    int? loadingPageNumber,
    bool clearLoadingPageNumber = false,
    int? scrollToTopSignal,
    bool triggerScrollToTop = false,
    String? errorMessage,
    PackagesAction? pendingAction,
    bool clearPendingAction = false,
    int? actionNonce,
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
      isPageChangeLoading: isPageChangeLoading ?? this.isPageChangeLoading,
      loadingPageNumber: clearLoadingPageNumber
          ? null
          : loadingPageNumber ?? this.loadingPageNumber,
      scrollToTopSignal: triggerScrollToTop
          ? this.scrollToTopSignal + 1
          : scrollToTopSignal ?? this.scrollToTopSignal,
      errorMessage: errorMessage,
      pendingAction: clearPendingAction
          ? null
          : pendingAction ?? this.pendingAction,
      actionNonce: actionNonce ?? this.actionNonce,
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
    isPageChangeLoading,
    loadingPageNumber,
    scrollToTopSignal,
    errorMessage,
    pendingAction,
    actionNonce,
  ];
}
