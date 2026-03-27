import 'package:equatable/equatable.dart';
import 'package:tourismapp/core/extensions/request_state.dart';
import 'package:tourismapp/features/home/domain/entities/packages_page_entity.dart';

class FavouritePlacesState extends Equatable {
  final RequestState status;
  final PackagesPageEntity? favoritesPage;
  final String? errorMessage;
  final int currentPage;

  const FavouritePlacesState({
    required this.status,
    required this.favoritesPage,
    this.errorMessage,
    required this.currentPage,
  });

  const FavouritePlacesState.initial()
    : status = RequestState.init,
      favoritesPage = null,
      errorMessage = null,
      currentPage = 1;

  FavouritePlacesState copyWith({
    RequestState? status,
    PackagesPageEntity? favoritesPage,
    String? errorMessage,
    int? currentPage,
  }) {
    return FavouritePlacesState(
      status: status ?? this.status,
      favoritesPage: favoritesPage ?? this.favoritesPage,
      errorMessage: errorMessage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [status, favoritesPage, errorMessage, currentPage];
}
