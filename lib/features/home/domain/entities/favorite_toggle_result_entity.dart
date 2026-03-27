import 'package:equatable/equatable.dart';

class FavoriteToggleResultEntity extends Equatable {
  final String message;
  final bool isFavorite;

  const FavoriteToggleResultEntity({
    required this.message,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [message, isFavorite];
}
