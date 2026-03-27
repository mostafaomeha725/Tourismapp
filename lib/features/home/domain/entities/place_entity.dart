import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  final int id;
  final String title;
  final String icon;
  final String? subTitle;
  final String? location;
  final double? lat;
  final double? lng;

  const PlaceEntity({
    required this.id,
    required this.title,
    required this.icon,
    this.subTitle,
    this.location,
    this.lat,
    this.lng,
  });

  @override
  List<Object?> get props => [id, title, icon, subTitle, location, lat, lng];
}
