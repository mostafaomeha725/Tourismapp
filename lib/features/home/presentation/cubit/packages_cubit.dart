import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/home/domain/entities/category_entity.dart';
import 'package:tourismapp/features/home/domain/entities/package_entity.dart';
import 'package:tourismapp/features/home/domain/entities/place_entity.dart';
import 'package:tourismapp/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_packages_price_range_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_packages_usecase.dart';
import 'package:tourismapp/features/home/domain/usecases/get_places_usecase.dart';

part 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final GetPackagesUseCase getPackagesUseCase;
  final GetPackagesPriceRangeUseCase getPackagesPriceRangeUseCase;
  final GetPlacesUseCase getPlacesUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  PackagesCubit(
    this.getPackagesUseCase,
    this.getPackagesPriceRangeUseCase,
    this.getPlacesUseCase,
    this.getCategoriesUseCase,
  ) : super(const PackagesState.initial());

  Future<void> loadInitialData() async {
    emit(state.copyWith(status: RequestState.loading, errorMessage: null));

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
      GetPackagesParams(minPrice: minPrice, maxPrice: maxPrice, page: 1),
    );

    packagesResult.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestState.error,
          places: places,
          categories: categories,
          minPrice: minPrice,
          maxPrice: maxPrice,
          errorMessage: failure.message,
        ),
      ),
      (packagesPage) => emit(
        state.copyWith(
          status: RequestState.success,
          packages: packagesPage.items,
          places: places,
          categories: categories,
          currentPage: packagesPage.currentPage,
          totalPages: packagesPage.lastPage,
          minPrice: minPrice,
          maxPrice: maxPrice,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> getPackages({
    String? search,
    int? categoryId,
    int? providerId,
    int? placeId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
  }) async {
    emit(state.copyWith(status: RequestState.loading, errorMessage: null));

    final result = await getPackagesUseCase(
      GetPackagesParams(
        search: search,
        categoryId: categoryId,
        providerId: providerId,
        placeId: placeId,
        minPrice: minPrice ?? state.minPrice,
        maxPrice: maxPrice ?? state.maxPrice,
        page: page,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (packagesPage) => emit(
        state.copyWith(
          status: RequestState.success,
          packages: packagesPage.items,
          currentPage: packagesPage.currentPage,
          totalPages: packagesPage.lastPage,
          errorMessage: null,
        ),
      ),
    );
  }
}
