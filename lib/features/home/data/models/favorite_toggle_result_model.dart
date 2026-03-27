import 'package:tourismapp/features/home/domain/entities/favorite_toggle_result_entity.dart';

class FavoriteToggleResultModel extends FavoriteToggleResultEntity {
  const FavoriteToggleResultModel({
    required super.message,
    required super.isFavorite,
  });

  factory FavoriteToggleResultModel.fromJson(Map<String, dynamic> json) {
    return FavoriteToggleResultModel(
      message: (json['message'] ?? '').toString(),
      isFavorite: json['is_favorite'] == true,
    );
  }
}
