import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:tourismapp/features/service/domain/entities/category_entity.dart';
import 'package:tourismapp/features/service/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/domain/entities/place_entity.dart';
import 'package:tourismapp/features/service/domain/usecases/get_categories_usecase.dart';
import 'package:tourismapp/features/service/domain/usecases/get_packages_price_range_usecase.dart';
import 'package:tourismapp/features/service/domain/usecases/get_packages_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_places_usecase.dart';
import 'package:tourismapp/features/service/domain/usecases/resolve_package_booking_link_usecase.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final GetPackagesUseCase getPackagesUseCase;
  final GetPackagesPriceRangeUseCase getPackagesPriceRangeUseCase;
  final GetPlacesUseCase getPlacesUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final ResolvePackageBookingLinkUseCase resolvePackageBookingLinkUseCase;

  String? _inFlightRequestKey;
  int _latestGetPackagesRequestId = 0;
  bool _isLoadingInitialData = false;
  bool _isEasyLoadingVisible = false;
  GetPackagesParams _lastRequestedParams = const GetPackagesParams(page: 1);
  bool _hasRequestedPackages = false;

  PackagesCubit(
    this.getPackagesUseCase,
    this.getPackagesPriceRangeUseCase,
    this.getPlacesUseCase,
    this.getCategoriesUseCase,
    this.resolvePackageBookingLinkUseCase,
  ) : super(const PackagesState.initial());

  void _showServicesLoading() {
    if (_isEasyLoadingVisible) {
      return;
    }
    _isEasyLoadingVisible = true;
    showLoading(status: 'Loading services...');
  }

  void _hideServicesLoading() {
    if (!_isEasyLoadingVisible) {
      return;
    }
    _isEasyLoadingVisible = false;
    hideLoading();
  }

  void _showServicesError(String message) {
    _isEasyLoadingVisible = false;
    showError(message);
  }

  String _buildRequestKey(GetPackagesParams params) {
    final normalizedSearch = params.search?.trim();
    return [
      normalizedSearch == null || normalizedSearch.isEmpty
          ? ''
          : normalizedSearch,
      params.categoryId?.toString() ?? '',
      params.providerId?.toString() ?? '',
      params.placeId?.toString() ?? '',
      params.minPrice?.toStringAsFixed(2) ?? '',
      params.maxPrice?.toStringAsFixed(2) ?? '',
      (params.page ?? 1).toString(),
    ].join('|');
  }

  void onCardTapped(PackageEntity package) {
    _emitAction(PackagesAction.openPackageDetails(package.id));
  }

  void onBookTapped(PackageEntity package) {
    _resolveAndEmitExternalLink(
      rawLink: package.link,
      unavailableMessage: 'Package booking link is not available yet.',
      invalidMessage: 'Package booking link is invalid.',
    );
  }

  void onLocationTapped(PackageEntity package) {
    _resolveAndEmitExternalLink(
      rawLink: package.locationLink,
      unavailableMessage: 'Package location link is not available yet.',
      invalidMessage: 'Package location link is invalid.',
    );
  }

  void _resolveAndEmitExternalLink({
    required String? rawLink,
    required String unavailableMessage,
    required String invalidMessage,
  }) {
    final result = resolvePackageBookingLinkUseCase(rawLink);

    result.fold(
      (failure) {
        final message =
            failure.message ==
                ResolvePackageBookingLinkUseCase.invalidLinkMessage
            ? invalidMessage
            : unavailableMessage;

        _emitAction(PackagesAction.showError(message));
      },
      (link) {
        _emitAction(PackagesAction.openExternalLink(link));
      },
    );
  }

  void clearPendingAction() {
    if (state.pendingAction == null) {
      return;
    }

    emit(
      state.copyWith(
        clearPendingAction: true,
        actionNonce: state.actionNonce + 1,
      ),
    );
  }

  void _emitAction(PackagesAction action) {
    emit(
      state.copyWith(pendingAction: action, actionNonce: state.actionNonce + 1),
    );
  }

  Future<void> retryLastPackagesRequest() async {
    if (state.status.isLoading) {
      return;
    }

    if (_hasRequestedPackages) {
      final params = _lastRequestedParams;
      await getPackages(
        search: params.search,
        categoryId: params.categoryId,
        providerId: params.providerId,
        placeId: params.placeId,
        minPrice: params.minPrice,
        maxPrice: params.maxPrice,
        page: params.page ?? 1,
        forceRefresh: true,
      );
      return;
    }

    await loadInitialData(forceRefresh: true);
  }

  Future<void> loadInitialData({bool forceRefresh = false}) async {
    if (_isLoadingInitialData) {
      return;
    }

    final hasStateData =
        state.status.isSuccess &&
        state.packages.isNotEmpty &&
        state.categories.isNotEmpty &&
        state.places.isNotEmpty;

    if (!forceRefresh && hasStateData) {
      return;
    }

    _isLoadingInitialData = true;
    var didShowBlockingLoading = false;
    try {
      if (state.packages.isEmpty) {
        _showServicesLoading();
        didShowBlockingLoading = true;
        emit(
          state.copyWith(
            status: RequestState.loading,
            isPageChangeLoading: false,
            clearLoadingPageNumber: true,
            errorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isPageChangeLoading: false,
            clearLoadingPageNumber: true,
            errorMessage: null,
          ),
        );
      }

      final rangeResult = await getPackagesPriceRangeUseCase();
      final placesResult = await getPlacesUseCase();
      final categoriesResult = await getCategoriesUseCase();

      double minPrice = state.minPrice;
      double maxPrice = state.maxPrice;
      List<PlaceEntity> places = state.places;
      List<CategoryEntity> categories = state.categories;

      rangeResult.fold((_) {}, (range) {
        minPrice = range.minPrice;
        maxPrice = range.maxPrice;
      });

      placesResult.fold((_) {}, (result) {
        places = result;
      });

      categoriesResult.fold((_) {}, (result) {
        categories = result;
      });

      final packagesResult = await getPackagesUseCase(
        const GetPackagesParams(page: 1),
      );

      packagesResult.fold(
        (failure) {
          if (didShowBlockingLoading) {
            _showServicesError(failure.message);
          }
          final fallbackStatus = state.packages.isEmpty
              ? RequestState.error
              : RequestState.success;

          final nextState = state.copyWith(
            status: fallbackStatus,
            places: places,
            categories: categories,
            minPrice: minPrice,
            maxPrice: maxPrice,
            isPageChangeLoading: false,
            clearLoadingPageNumber: true,
            errorMessage: failure.message,
          );
          emit(nextState);
        },
        (packagesPage) {
          if (didShowBlockingLoading) {
            _hideServicesLoading();
          }
          final nextState = state.copyWith(
            status: RequestState.success,
            packages: packagesPage.items,
            places: places,
            categories: categories,
            currentPage: packagesPage.currentPage,
            totalPages: packagesPage.lastPage,
            minPrice: minPrice,
            maxPrice: maxPrice,
            isPageChangeLoading: false,
            clearLoadingPageNumber: true,
            errorMessage: null,
          );
          emit(nextState);
        },
      );
    } finally {
      _isLoadingInitialData = false;
    }
  }

  Future<void> getPackages({
    String? search,
    int? categoryId,
    int? providerId,
    int? placeId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final params = GetPackagesParams(
      search: search,
      categoryId: categoryId,
      providerId: providerId,
      placeId: placeId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      page: page,
    );

    _lastRequestedParams = params;
    _hasRequestedPackages = true;

    final requestKey = _buildRequestKey(params);
    final isPaginationRequest = page >= 1;
    final shouldShowPaginationLoading =
        isPaginationRequest &&
        state.status.isSuccess &&
        state.packages.isNotEmpty;

    if (_inFlightRequestKey == requestKey) {
      return;
    }

    final shouldBlockWithLoading =
        state.packages.isEmpty || state.status.isError;
    var didShowBlockingLoading = false;
    if (shouldBlockWithLoading) {
      _showServicesLoading();
      didShowBlockingLoading = true;
      emit(
        state.copyWith(
          status: RequestState.loading,
          isPageChangeLoading: false,
          clearLoadingPageNumber: true,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isPageChangeLoading: shouldShowPaginationLoading,
          loadingPageNumber: shouldShowPaginationLoading ? page : null,
          clearLoadingPageNumber: !shouldShowPaginationLoading,
          triggerScrollToTop: isPaginationRequest,
          errorMessage: null,
        ),
      );
    }

    final requestId = ++_latestGetPackagesRequestId;
    _inFlightRequestKey = requestKey;
    late final result;
    try {
      result = await getPackagesUseCase(params);
    } finally {
      if (_inFlightRequestKey == requestKey) {
        _inFlightRequestKey = null;
      }
    }

    if (requestId != _latestGetPackagesRequestId) {
      return;
    }

    result.fold(
      (failure) {
        if (shouldBlockWithLoading) {
          if (didShowBlockingLoading) {
            _showServicesError(failure.message);
          }
          final nextState = state.copyWith(
            status: RequestState.error,
            isPageChangeLoading: false,
            clearLoadingPageNumber: true,
            errorMessage: failure.message,
          );
          emit(nextState);
          return;
        }

        final nextState = state.copyWith(
          isPageChangeLoading: false,
          clearLoadingPageNumber: true,
          errorMessage: failure.message,
        );
        emit(nextState);
      },
      (packagesPage) {
        if (didShowBlockingLoading) {
          _hideServicesLoading();
        }
        final nextState = state.copyWith(
          status: RequestState.success,
          packages: packagesPage.items,
          currentPage: packagesPage.currentPage,
          totalPages: packagesPage.lastPage,
          isPageChangeLoading: false,
          clearLoadingPageNumber: true,
          triggerScrollToTop: isPaginationRequest,
          errorMessage: null,
        );
        emit(nextState);
      },
    );
  }
}
