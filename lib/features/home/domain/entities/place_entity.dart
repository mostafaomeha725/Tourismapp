import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  final int id;
  final String title;
  final String icon;

  const PlaceEntity({
    required this.id,
    required this.title,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, title, icon];
}
