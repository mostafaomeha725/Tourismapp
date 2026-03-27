import 'package:tourismapp/features/home/domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.id,
    required super.title,
    required super.icon,
    super.subTitle,
    super.location,
    super.lat,
    super.lng,
  });

  static double? _toNullableDouble(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value.toString());
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] is int ? json['id'] as int : 0,
      title: (json['title'] ?? '').toString(),
      icon: (json['icon'] ?? '').toString(),
      subTitle: json['sub_title']?.toString(),
      location: json['location']?.toString(),
      lat: _toNullableDouble(json['lat']),
      lng: _toNullableDouble(json['lng']),
    );
  }
}
