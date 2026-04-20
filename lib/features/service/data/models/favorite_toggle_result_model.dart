import 'package:tourismapp/features/service/domain/entities/favorite_toggle_result_entity.dart';

class FavoriteToggleResultModel extends FavoriteToggleResultEntity {
  const FavoriteToggleResultModel({
    required super.message,
    required super.isFavorite,
  });

  static bool _parseIsFavorite(Map<String, dynamic> json) {
    final raw = json.containsKey('is_favorite')
        ? json['is_favorite']
        : json['isFavorite'];

    if (raw is bool) return raw;
    if (raw is num) return raw != 0;
    if (raw is String) {
      final value = raw.trim().toLowerCase();
      return value == '1' || value == 'true' || value == 'yes';
    }

    return false;
  }

  factory FavoriteToggleResultModel.fromJson(Map<String, dynamic> json) {
    return FavoriteToggleResultModel(
      message: (json['message'] ?? '').toString(),
      isFavorite: _parseIsFavorite(json),
    );
  }
}
