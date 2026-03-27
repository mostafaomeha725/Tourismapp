import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourismapp/features/home/domain/entities/place_entity.dart';
import 'package:tourismapp/features/home/domain/usecases/get_places_usecase.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final GetPlacesUseCase getPlacesUseCase;

  PlacesCubit(this.getPlacesUseCase) : super(const PlacesInitial());

  Future<void> loadPlaces() async {
    emit(const PlacesLoading());

    final result = await getPlacesUseCase();

    result.fold((failure) => emit(PlacesFailure(failure.message)), (places) {
      if (places.isEmpty) {
        emit(const PlacesEmpty());
        return;
      }
      emit(PlacesSuccess(places));
    });
  }
}
