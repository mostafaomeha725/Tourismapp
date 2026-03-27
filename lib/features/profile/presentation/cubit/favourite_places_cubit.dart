import 'package:bloc/bloc.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/home/domain/usecases/get_favorites_usecase.dart';
import 'package:tourismapp/features/profile/presentation/cubit/favourite_places_state.dart';

class FavouritePlacesCubit extends Cubit<FavouritePlacesState> {
  final GetFavoritesUseCase getFavoritesUseCase;

  FavouritePlacesCubit(this.getFavoritesUseCase)
    : super(const FavouritePlacesState.initial());

  Future<void> loadFavorites({int? page}) async {
    final targetPage = page ?? state.currentPage;

    emit(
      state.copyWith(
        status: RequestState.loading,
        currentPage: targetPage,
        errorMessage: null,
      ),
    );

    final result = await getFavoritesUseCase(
      GetFavoritesParams(page: targetPage),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestState.error,
          errorMessage: failure.message,
        ),
      ),
      (favoritesPage) => emit(
        state.copyWith(
          status: RequestState.success,
          favoritesPage: favoritesPage,
          currentPage: favoritesPage.currentPage,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> onPageChanged(int page) async {
    if (page == state.currentPage) {
      return;
    }
    await loadFavorites(page: page);
  }
}
