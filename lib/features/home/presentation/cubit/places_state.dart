part of 'places_cubit.dart';

sealed class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object?> get props => [];
}

final class PlacesInitial extends PlacesState {
  const PlacesInitial();
}

final class PlacesLoading extends PlacesState {
  const PlacesLoading();
}

final class PlacesSuccess extends PlacesState {
  final List<PlaceEntity> places;

  const PlacesSuccess(this.places);

  @override
  List<Object?> get props => [places];
}

final class PlacesEmpty extends PlacesState {
  const PlacesEmpty();
}

final class PlacesFailure extends PlacesState {
  final String message;

  const PlacesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
