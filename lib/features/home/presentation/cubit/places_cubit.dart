import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/utils/easy_loading.dart';
import 'package:tourismapp/features/home/domain/entities/place_entity.dart';
import 'package:tourismapp/features/home/domain/usecases/get_places_usecase.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final GetPlacesUseCase getPlacesUseCase;
  bool _isEasyLoadingVisible = false;

  PlacesCubit(this.getPlacesUseCase) : super(const PlacesInitial());

  void _showPlacesLoading() {
    if (_isEasyLoadingVisible) {
      return;
    }
    _isEasyLoadingVisible = true;
    showLoading(status: 'Loading tourist places...');
  }

  void _hidePlacesLoading() {
    if (!_isEasyLoadingVisible) {
      return;
    }
    _isEasyLoadingVisible = false;
    hideLoading();
  }

  void _showPlacesError(String message) {
    _isEasyLoadingVisible = false;
    showError(message);
  }

  Future<void> loadPlaces() async {
    if (state is PlacesLoading) {
      return;
    }

    _showPlacesLoading();
    emit(const PlacesLoading());

    final result = await getPlacesUseCase();

    result.fold(
      (failure) {
        _showPlacesError(failure.message);
        emit(PlacesFailure(failure.message));
      },
      (places) {
        _hidePlacesLoading();
        if (places.isEmpty) {
          emit(const PlacesEmpty());
          return;
        }
        emit(PlacesSuccess(places));
      },
    );
  }
}
